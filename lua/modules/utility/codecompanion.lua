-- Parse bedrock streaming response into format expected by regular anthropic adapter
local function parse_bedrock_stream(chunk)
    local decoded_chunks = {}
    for bedrock_data_match in chunk:gmatch 'event(%b{})' do
        local ok, json_data = pcall(vim.json.decode, bedrock_data_match)
        if ok and json_data.bytes then
            local decoded_data = vim.base64.decode(json_data.bytes)
            table.insert(decoded_chunks, decoded_data)
        end
    end
    return decoded_chunks
end

-- Success marker from upstream anthropic adapter
local STATUS_SUCCESS = 'success'

-- Merge content strings
local function merge_content(target, source)
    if not source or source == '' then return target end
    return (target or '') .. source
end

-- Merge dicts of type { content: str, signature: str }
local function merge_reasoning(target, source)
    if not source then return target end
    target = target or { content = nil, signature = nil }
    target.content = merge_content(target.content, source.content)
    target.signature = merge_content(target.signature, source.signature)
    return target
end

return {
    {
        'olimorris/codecompanion.nvim',
        lazy = true,
        cmd = {
            'CodeCompanion',
            'CodeCompanionActions',
            'CodeCompanionCLI',
            'CodeCompanionCmd',
            'CodeCompanionChat',
        },
        keys = {
            { '<leader>ac', ':CodeCompanionChat toggle<CR>', desc = 'Toggle chat' },
            { '<leader>aa', ':CodeCompanionAction<CR>',      desc = 'Run action' },
            { '<leader>ai', ':CodeCompanion<CR>',            desc = 'Inline interaction' },
            { '<leader>am', ':CodeCompanionCmd<CR>',         desc = 'Run command' },
            { '<leader>at', ':CodeCompanionCLI<CR>',         desc = 'Interact with agent' },
        },
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
            '3ZsForInsomnia/code-companion-picker',
        },
        opts = {
            -- NOTE: The log_level is in `opts.opts`
            opts = {
                log_level = "DEBUG", -- or "TRACE"
            },
            adapters = {
                http = {
                    copilot = false,
                    bedrock = function()
                        local anthropic = require 'codecompanion.adapters.http.anthropic'

                        ---@class Bedrock.Adapter: CodeCompanion.Adapter
                        return require('codecompanion.adapters').extend('anthropic', {
                            name = 'bedrock',
                            formatted_name = 'Bedrock',
                            url = 'https://bedrock-runtime.${aws_region}.amazonaws.com/model/${model}/${endpoint}',
                            env = {
                                aws_access_key_id = 'AWS_ACCESS_KEY_ID',
                                aws_region = 'schema.region.default',
                                aws_secret_access_key = "AWS_SECRET_ACCESS_KEY",
                                aws_session_token = "AWS_SESSION_TOKEN",
                                endpoint = function(self)
                                    if self.opts.stream then
                                        return 'invoke-with-response-stream'
                                    else
                                        return 'invoke'
                                    end
                                end,
                                model = 'schema.model.default',
                            },
                            headers = {
                                ['x-amz-security-token'] = '${aws_session_token}',
                            },
                            raw = {
                                '--aws-sigv4',
                                'aws:amz:${aws_region}:bedrock',
                                '--user',
                                '${aws_access_key_id}:${aws_secret_access_key}',
                            },
                            handlers = {
                                setup = function(_) return true end,
                                tokens = function(self, data)
                                    local total_tokens = 0
                                    if self.opts.stream then
                                        for _, message in ipairs(parse_bedrock_stream(data)) do
                                            total_tokens = total_tokens + (anthropic.handlers.tokens(self, message) or 0)
                                        end
                                    else
                                        total_tokens = anthropic.handlers.tokens(self, data)
                                    end
                                    return total_tokens
                                end,
                                chat_output = function(self, data, tools)
                                    if not self.opts.stream then return anthropic.handlers.chat_output(self, data, tools) end

                                    local output = { role = nil, reasoning = nil, content = nil }
                                    local chunks = parse_bedrock_stream(data)
                                    if not chunks or #chunks == 0 then return { status = STATUS_SUCCESS, output = output } end

                                    for _, message in ipairs(chunks) do
                                        local part = anthropic.handlers.chat_output(self, message, tools)
                                        if not part then goto continue end

                                        -- Handle error status
                                        if part.status ~= STATUS_SUCCESS then
                                            return {
                                                status = part.status,
                                                output =
                                                    output
                                            }
                                        end

                                        -- Merge successful response data
                                        if part.output then
                                            output.role = output.role or part.output.role
                                            output.reasoning = merge_reasoning(output.reasoning, part.output.reasoning)
                                            output.content = merge_content(output.content, part.output.content)
                                        end

                                        ::continue::
                                    end
                                    return {
                                        status = STATUS_SUCCESS,
                                        output = output,
                                    }
                                end,
                                form_messages = function(self, messages)
                                    local has_tools = false
                                    local adapter_utils = require("codecompanion.adapters.utils")

                                    -- 1. Extract and format system messages
                                    local system = vim
                                        .iter(messages)
                                        :filter(function(msg)
                                            return msg.role == "system" and msg.content and msg.content ~= ""
                                        end)
                                        :map(function(msg)
                                            return {
                                                type = "text",
                                                text = msg.content,
                                                cache_control = nil, -- To be set later if needed
                                            }
                                        end)
                                        :totable()
                                    system = next(system) and system or nil

                                    -- 2. Remove any system messages from the regular messages
                                    messages = vim
                                        .iter(messages)
                                        :filter(function(msg)
                                            return msg.role ~= "system"
                                        end)
                                        :totable()

                                    -- 3–7. Clean up, role‐convert, and handle tool calls in one pass
                                    messages = vim.tbl_map(function(m)
                                        -- 3. Account for any images
                                        if m._meta and m._meta.tag == "image" and m.context and m.context.mimetype then
                                            if self.opts and self.opts.vision then
                                                m.content = {
                                                    {
                                                        type = "image",
                                                        source = {
                                                            type = "base64",
                                                            media_type = m.context.mimetype,
                                                            data = m.content,
                                                        },
                                                    },
                                                }
                                            else
                                                -- Remove the message if vision is not supported
                                                return nil
                                            end
                                        end

                                        -- 4. Remove disallowed keys
                                        m = adapter_utils.filter_out_messages({
                                            message = m,
                                            allowed_words = {
                                                "content",
                                                "role",
                                                "reasoning",
                                                "tools",
                                            },
                                        })

                                        -- 5. Turn string content into { { type = "text", text } } and add in the reasoning
                                        if m.role == self.roles.user or m.role == self.roles.llm then
                                            -- Anthropic doesn't allow the user to submit an empty prompt. But
                                            -- this can be necessary to prompt the LLM to analyze any tool
                                            -- calls and their output
                                            if m.role == self.roles.user and m.content == "" then
                                                m.content = "<prompt></prompt>"
                                            end

                                            if type(m.content) == "string" then
                                                m.content = {
                                                    { type = "text", text = m.content },
                                                }
                                            end
                                        end

                                        if m.tools and m.tools.calls and vim.tbl_count(m.tools.calls) > 0 then
                                            has_tools = true
                                        end

                                        -- 6. Treat 'tool' role as user and convert tool results to Anthropic format
                                        if m.role == "tool" then
                                            m.role = self.roles.user
                                            -- Convert tool result from CodeCompanion format to Anthropic format
                                            if m.tools and m.tools.type == "tool_result" then
                                                -- Handle content that might already be in Anthropic's format
                                                if type(m.content) == "table" and m.content.type == "tool_result" then
                                                    -- Already in Anthropic format, keep it as-is but ensure it's in an array
                                                    m.content = { m.content }
                                                else
                                                    -- Convert from CodeCompanion format to Anthropic format
                                                    m.content = {
                                                        {
                                                            type = "tool_result",
                                                            tool_use_id = m.tools.call_id,
                                                            content = m.content,
                                                            is_error = m.tools.is_error or false,
                                                        },
                                                    }
                                                end
                                                m.tools = nil
                                            end
                                        end

                                        -- 7. Convert any LLM tool_calls into content blocks
                                        if has_tools and m.role == self.roles.llm and m.tools and m.tools.calls then
                                            m.content = m.content or {}
                                            for _, call in ipairs(m.tools.calls) do
                                                local args = call["function"].arguments
                                                table.insert(m.content, {
                                                    type = "tool_use",
                                                    id = call.id,
                                                    name = call["function"].name,
                                                    input = args ~= "" and vim.json.decode(args) or vim.empty_dict(),
                                                })
                                            end
                                            m.tools = nil
                                        end

                                        -- 8. If reasoning is present, format it as a content block
                                        if m.reasoning and type(m.content) == "table" then
                                            -- Ref: https://docs.anthropic.com/en/docs/build-with-claude/extended-thinking#how-extended-thinking-works
                                            table.insert(m.content, 1, {
                                                type = "thinking",
                                                thinking = m.reasoning.content,
                                                signature = m.reasoning._data.signature,
                                            })
                                        end

                                        return m
                                    end, messages)

                                    -- 9. Merge consecutive messages with the same role
                                    messages = adapter_utils.merge_messages(messages)

                                    -- 10. Ensure that any consecutive tool results are merged and text messages are included
                                    if has_tools then
                                        for _, m in ipairs(messages) do
                                            if m.role == self.roles.user and m.content and m.content ~= "" then
                                                -- Check if content is already an array of blocks
                                                if type(m.content) == "table" and m.content.type then
                                                    -- If it's a single content block (like a tool_result), make it an array
                                                    m.content = { m.content }
                                                end

                                                -- Now we can iterate over the content blocks
                                                if type(m.content) == "table" and vim.islist(m.content) then
                                                    local consolidated = {}
                                                    for _, block in ipairs(m.content) do
                                                        if block.type == "tool_result" then
                                                            local prev = consolidated[#consolidated]
                                                            if prev and prev.type == "tool_result" and prev.tool_use_id == block.tool_use_id then
                                                                -- Merge consecutive tool results with the same tool_use_id
                                                                prev.content = prev.content .. block.content
                                                            else
                                                                table.insert(consolidated, block)
                                                            end
                                                        else
                                                            table.insert(consolidated, block)
                                                        end
                                                    end
                                                    m.content = consolidated
                                                end
                                            end
                                        end
                                    end

                                    -- 11. Disable automatic prompt caching, not supported by bedrock
                                    return {
                                        cache_control = nil,
                                        system = system,
                                        messages = messages,
                                        -- context_management = context_management,
                                    }
                                end,
                            },
                            schema = {
                                model = {
                                    mapping = 'temp',
                                    default = 'us.anthropic.claude-opus-5-5',
                                    choices = {
                                        ['us.anthropic.claude-fable-5'] = { opts = { can_reason = true, has_vision = true } },
                                        ['us.anthropic.claude-sonnet-5'] = { opts = { can_reason = true, has_vision = true } },
                                    },
                                },
                                region = {
                                    type = 'string',
                                    default = 'us-east-1',
                                    desc = 'AWS region',
                                    choices = {
                                        'us-east-1',
                                    },
                                },
                                anthropic_version = {
                                    mapping = 'parameters',
                                    type = 'string',
                                    optional = false,
                                    default = 'bedrock-2023-05-31',
                                    desc = 'Bedrock anthropic API version',
                                },
                            },
                        })
                    end,
                },
                opts = {
                    show_presets = false, -- Only display adapters defined in your config
                }
            },
            display = {
                action_palette = {
                    provider = 'snacks',
                },
                chat = {
                    -- show_settings = true,
                    window = {
                        layout = 'vertical',
                        position = 'right',
                    },
                    icons = {
                        chat_context = "📎️", -- You can also apply an icon to the fold
                    },
                    fold_context = true,
                },
            },
            interactions = {
                chat = {
                    adapter = 'bedrock',
                },
                inline = {
                    adapter = 'bedrock',
                },
                cmd = {
                    adapter = "bedrock",
                },
                cli = {
                    agent = "claude_code",
                    agents = {
                        claude_code = {
                            cmd = "claude",
                            args = {},
                            description = "Claude Code CLI",
                            provider = "terminal",
                        },
                    },
                },
                background = {
                    adapter = 'bedrock',
                    chat = {
                        callbacks = {
                            ["on_ready"] = {
                                actions = {
                                    "interactions.background.builtin.chat_make_title",
                                },
                                adapter = 'bedrock',
                                -- Enable "on_ready" callback which contains the title generation action
                                enabled = true,
                            },
                        },
                        opts = {
                            -- Enable background interactions generally
                            enabled = true,
                        },
                    },
                },
            },
        },
    },
}
