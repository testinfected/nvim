--[[
  File: cmp.lua
  Description: Completion engine plugin for neovim
  See: https://github.com/hrsh7th/nvim-cmp
]]

local M = {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-emoji',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'hrsh7th/cmp-nvim-lua',
        'saadparwaiz1/cmp_luasnip',
        'L3MON4D3/LuaSnip',
        'rafamadriz/friendly-snippets',
    },
}

function M.config()
    local cmp = require('cmp')
    local lspkind = require('lspkind')
    local luasnip = require('luasnip')
    local icons = require('config.icons')

    cmp.setup {
        completion = {
            -- Disable the completion menu, you must invoke it with <c-space>
            -- autocomplete = false,
            completeopt = 'menu,menuone,longest,preview,noinsert,noselect'
        },

        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body) -- Luasnip expand
            end
        },

        mapping = cmp.mapping.preset.insert {
            -- Scroll text in documentation window
            ['<C-u>'] = cmp.mapping.scroll_docs(-4),
            ['<C-d>'] = cmp.mapping.scroll_docs(4),
            -- toggle completion
            ['<C-Space>'] = cmp.mapping(function() if cmp.visible() then cmp.abort() else cmp.complete() end end),
            -- navigate completion entries with TAB
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_locally_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
                end
            end),
            ["<S-Tab>"] = cmp.mapping(function()
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) == 1 then
                    luasnip.jump(-1)
                end
            end),
            -- Jump to the next placeholder in the snippet.
            ['<C-f>'] = cmp.mapping(function(fallback) if luasnip.jumpable(1) then luasnip.jump(1) else fallback() end end),
            -- go to previous placeholder in the snippet
            ['<C-b>'] = cmp.mapping(function(fallback) if luasnip.jumpable(-1) then luasnip.jump(-1) else fallback() end end),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
        },

        sources = cmp.config.sources({
            { name = 'nvim_lsp' },          -- LSP
            { name = 'nvim_lsp_signature_help' }, -- LSP for parameters in functions
            { name = 'nvim_lua' },          -- Lua Neovim API
            { name = 'luasnip' },           -- Luasnip
            { name = 'path' },              -- Paths
        }, {
            { name = 'buffer' }
        }),

        formatting = {
            -- changing the order of fields so the icon is the first
            fields = { 'menu', 'abbr', 'kind' },

            format = lspkind.cmp_format {
                -- defines how annotations are shown
                -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
                mode = 'symbol_text',
                maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                -- symbol map, defaults or codicons
                -- preset = 'codicons',

                menu = {
                    nvim_lsp = icons.lsp.Lambda,
                    luasnip = icons.kind.Snippet,
                    buffer = icons.file.Modified,
                    path = icons.file.Path,
                    nvim_lua = icons.lsp.Lua,
                    latex_symbols = icons.lsp.Latex,
                }
            }
        },

        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },

        experimental = {
            ghost_text = true,
        },
    }

    -- Use buffer source for `/` and `?` (don't enable `native_menu`, otherwise this won't work).
    cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' }
        }
    })

    -- Use cmdline & path source for ':' (don't enable `native_menu`, otherwise this won't work).
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline {
            ['<C-y>'] = {
                c = cmp.mapping.close(), --avoids ghost text behavior with noice
            },
        },
        sources = cmp.config.sources({
            { name = 'path' }
        }, {
            { name = 'cmdline' }
        }),
    })

    -- Add snippets from Friendly Snippets
    require('luasnip/loaders/from_vscode').lazy_load()
end

return M
