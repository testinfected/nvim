--[[
  Description: A blazing fast and easy to configure neovim statusline plugin
  See: https://github.com/nvim-lualine/lualine.nvim
]]

return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "catppuccin",
    },
    event = { "VimEnter" },
    config = function()
        local colors = {
            rosewater = "#f2d5cf",
            flamingo = "#eebebe",
            pink = "#f4b8e4",
            mauve = "#ca9ee6",
            red = "#e78284",
            maroon = "#ea999c",
            peach = "#ef9f76",
            yellow = "#e5c890",
            green = "#a6d189",
            teal = "#81c8be",
            sky = "#99d1db",
            sapphire = "#85c1dc",
            blue = "#8caaee",
            lavender = "#babbf1",
            text = "#c6d0f5",
            subtext1 = "#b5bfe2",
            subtext0 = "#a5adce",
            overlay2 = "#949cbb",
            overlay1 = "#838ba7",
            overlay0 = "#737994",
            surface2 = "#626880",
            surface1 = "#51576d",
            surface0 = "#414559",
            base = "#303446",
            mantle = "#292c3c",
            crust = "#232634",
        }

        local icons = require("config.icons")
        local function custom_branch()
            local gitsigns = vim.b.gitsigns_head
            local branch = gitsigns
            if branch == nil or branch == "" then
                return icons.git.Branch
            else
                return icons.git.Branch .. " " .. branch
            end
        end

        local auto = require("lualine.themes.auto")
        local modes = { "normal", "insert", "visual", "replace", "command", "inactive", "terminal" }
        for _, mode in ipairs(modes) do
            if auto[mode] and auto[mode].c then
                auto[mode].c.bg = "NONE"
            end
        end
        local function separator()
            return {
                function()
                    return icons.ui.VerticalDottedLine
                end,
                color = { fg = colors.surface0, bg = "NONE", gui = "bold" },
                padding = { left = 1, right = 1 },
            }
        end

        vim.o.showmode = false -- Don't show mode anymore, lualine takes care of that

        require("lualine").setup({
            options = {
                theme = "auto",
                component_separators = "",
                section_separators = "",
                globalstatus = true,
                -- section_separators = { left = icons.ui.RightPill, right = icons.ui.LeftPill },
                disabled_filetypes = {
                    "snacks_layout_box",
                    "",
                    "quickfix",
                },
            },
            sections = {
                lualine_a = {
                    {
                        "mode",
                        fmt = function(str)
                            return str:sub(1, 1)
                        end,
                        color = function()
                            local mode = vim.fn.mode()
                            if mode == "\22" then
                                return { fg = "none", bg = colors.red, gui = "bold" }
                            elseif mode == "V" then
                                return { fg = colors.red, bg = "none", gui = "underline,bold" }
                            else
                                return { fg = colors.red, bg = "none", gui = "bold" }
                            end
                        end,
                        padding = { left = 0, right = 0 },
                    },
                },
                lualine_b = {
                    separator(),
                    {
                        custom_branch,
                        color = { fg = colors.green, bg = "none", gui = "bold" },
                        padding = { left = 0, right = 0 },
                    },
                    {
                        "diff",
                        colored = true,
                        diff_color = {
                            added = { fg = colors.teal, bg = "none", gui = "bold" },
                            modified = { fg = colors.yellow, bg = "none", gui = "bold" },
                            removed = { fg = colors.red, bg = "none", gui = "bold" },
                        },
                        symbols = { added = "+", modified = "~", removed = "-" },
                        source = nil,
                        padding = { left = 1, right = 0 },
                    },
                },
                lualine_c = {
                    separator(),
                    {
                        "filetype",
                        icon_only = true,
                        colored = false,
                        color = { fg = colors.blue, bg = "none", gui = "bold" },
                        padding = { left = 0, right = 1 },
                    },
                    {
                        "filename",
                        file_status = true,
                        path = 0,
                        shorting_target = 20,
                        symbols = {
                            modified = "[+]",
                            readonly = "[-]",
                            unnamed = "[?]",
                            newfile = "[!]",
                        },
                        color = { fg = colors.blue, bg = "none", gui = "bold" },
                        padding = { left = 0, right = 0 },
                    },
                    separator(),
                    {
                        function()
                            local bufnr_list = vim.fn.getbufinfo({ buflisted = 1 })
                            local total = #bufnr_list
                            local current_bufnr = vim.api.nvim_get_current_buf()
                            local current_index = 0

                            for i, buf in ipairs(bufnr_list) do
                                if buf.bufnr == current_bufnr then
                                    current_index = i
                                    break
                                end
                            end

                            return string.format(" %d/%d", current_index, total)
                        end,
                        color = { fg = colors.yellow, bg = "none", gui = "bold" },
                        padding = { left = 0, right = 0 },
                    },
                    function()
                        return require("screenkey").get_keys()
                    end,
                },
                lualine_x = {
                    {
                        "fileformat",
                        color = { fg = colors.yellow, bg = "none", gui = "bold" },
                        symbols = {
                            unix = icons.os.Unix,
                            dos = icons.os.Dos,
                            mac = icons.os.Mac,
                        },
                        padding = { left = 0, right = 0 },
                    },
                    {
                        "encoding",
                        color = { fg = colors.yellow, bg = "none", gui = "bold" },
                        padding = { left = 1, right = 0 },
                    },
                    separator(),
                    {
                        function()
                            local size = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
                            if size < 0 then
                                return "-"
                            else
                                if size < 1024 then
                                    return size .. "B"
                                elseif size < 1024 * 1024 then
                                    return string.format("%.1fK", size / 1024)
                                elseif size < 1024 * 1024 * 1024 then
                                    return string.format("%.1fM", size / (1024 * 1024))
                                else
                                    return string.format("%.1fG", size / (1024 * 1024 * 1024))
                                end
                            end
                        end,
                        color = { fg = colors.blue, bg = "none", gui = "bold" },
                        padding = { left = 0, right = 0 },
                    },
                    separator(),
                    {
                        require("noice").api.status.command.get,
                        cond = require("noice").api.status.command.has,
                        color = { fg = colors.mauve },
                    },
                    {
                        require("noice").api.status.mode.get,
                        cond = require("noice").api.status.mode.has,
                        color = { fg = colors.mauve },
                    },
                },
                lualine_y = {
                    separator(),
                    {
                        "diagnostics",
                        sources = { "nvim_diagnostic", "coc" },
                        sections = { "error", "warn", "info", "hint" },
                        diagnostics_color = {
                            error = function()
                                local count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
                                return { fg = (count == 0) and colors.green or colors.red, bg = "none", gui = "bold" }
                            end,
                            warn = function()
                                local count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
                                return { fg = (count == 0) and colors.green or colors.yellow, bg = "none", gui = "bold" }
                            end,
                            info = function()
                                local count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
                                return { fg = (count == 0) and colors.green or colors.blue, bg = "none", gui = "bold" }
                            end,
                            hint = function()
                                local count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
                                return { fg = (count == 0) and colors.green or colors.teal, bg = "none", gui = "bold" }
                            end,
                        },
                        symbols = {
                            error = "󰅚 ",
                            warn = "󰀪 ",
                            info = "󰋽 ",
                            hint = "󰌶 ",
                        },
                        colored = true,
                        update_in_insert = false,
                        always_visible = true,
                        padding = { left = 0, right = 0 },
                    },
                },
                lualine_z = {
                    separator(),
                    {
                        "progress",
                        color = { fg = colors.red, bg = "none", gui = "bold" },
                        padding = { left = 0, right = 0 },
                    },
                    {
                        "location",
                        color = { fg = colors.red, bg = "none", gui = "bold" },
                        padding = { left = 1, right = 0 },
                    },
                }
            },
            inactive_sections = {
                lualine_a = { "filename" },
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = { "location" },
            },
            tabline = {},
            extensions = {
                "lazy",
                "mason",
                "nvim-dap-ui",
                "quickfix",
            },
        })
    end,
}
