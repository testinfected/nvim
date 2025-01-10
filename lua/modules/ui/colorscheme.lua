--[[
  File: colorscheme.lua
  Description: Catppuccin theme for (Neo)vim
  See: https://github.com/catppuccin/nvim
]]

local M = {
    "catppuccin/nvim",
    name = "catppuccin",
    -- Load immediately to make it available for lazy
    lazy = false,
    -- Load before anything else since this is our main theme
    priority = 1000,
}

function M.config()
    local catppuccin = require("catppuccin")
    local transparent_background = true
    local clear = {}

    catppuccin.setup({
        --flavor = 'macchiato',
        flavor = "mocha",
        transparent_background = transparent_background,
        term_colors = true,
        diam_inactive = {
            enabled = false,         -- dims the background color of inactive window
            shade = "dark",
            percentage = 0.15,       -- percentage of the shade to apply to the inactive window
        },
        styles = {                   -- Handles the styles of general hi groups (see `:h highlight-args`):
            comments = { "italic" }, -- Change the style of comments
            conditionals = { "italic" },
            loops = {},
            functions = {},
            keywords = {},
            startings = {},
            variables = {},
            numbers = {},
            booleans = {},
            properties = {},
            types = {},
            operators = {},
        },
        color_overrides = {},
        highlight_overrides = {
            all = function(color)
                return {
                    -- For base configs
                    NormalFloat = { fg = color.text, bg = transparent_background and color.none or color.mantle },
                    FloatBorder = {
                        fg = transparent_background and color.blue or color.mantle,
                        bg = transparent_background and color.none or color.mantle,
                    },
                    CursorLineNr = { fg = color.green },

                    -- For bufferline (with Barbar)
                    BufferTabpageFill = { bg = transparent_background and color.none or color.base },
                    BufferInactive = { bg = color.base },
                    BufferInactiveBtn = { bg = color.base },
                    BufferInactiveIcon = { bg = color.base },
                    BufferInactiveSign = { bg = color.base },
                    BufferInactiveIndex = { bg = color.base },
                    BufferInactiveNumber = { bg = color.base },
                    BufferInactivePin = { bg = color.base },

                    -- For native lsp configs
                    DiagnosticVirtualTextError = { bg = color.none },
                    DiagnosticVirtualTextWarn = { bg = color.none },
                    DiagnosticVirtualTextInfo = { bg = color.none },
                    DiagnosticVirtualTextHint = { bg = color.none },
                    LspInfoBorder = { link = "FloatBorder" },

                    -- For mason.nvim
                    MasonNormal = { link = "NormalFloat" },

                    -- For indent-blankline
                    IblIndent = { fg = color.surface0 },
                    IblScope = { fg = color.surface2, style = { "bold" } },

                    -- For completion menu
                    Pmenu = { fg = color.overlay2, bg = transparent_background and color.none or color.base },
                    PmenuBorder = { fg = color.surface1, bg = transparent_background and color.none or color.base },
                    -- PmenuSel = { bg = color.green, fg = color.base },
                    CmpItemAbbr = { fg = color.overlay2 },
                    CmpItemAbbrMatch = { fg = color.blue, style = { "bold" } },
                    CmpDoc = { link = "NormalFloat" },
                    CmpDocBorder = {
                        fg = transparent_background and color.surface1 or color.mantle,
                        bg = transparent_background and color.none or color.mantle,
                    },

                    NvimTreeRootFolder = { fg = color.pink },
                    NvimTreeIndentMarker = { fg = color.surface2 },

                    -- For trouble.nvim
                    TroubleNormal = { bg = transparent_background and color.none or color.base },

                    -- For telescope.nvim
                    TelescopeMatching = { fg = color.lavender },
                    TelescopeResultsDiffAdd = { fg = color.green },
                    TelescopeResultsDiffChange = { fg = color.yellow },
                    TelescopeResultsDiffDelete = { fg = color.red },

                    -- For treesitter
                    ["@keyword.return"] = { fg = color.pink, style = clear },
                    ["@error.c"] = { fg = color.none, style = clear },
                    ["@error.cpp"] = { fg = color.none, style = clear },
                }
            end,
        },

        integrations = {
            barbar = true,
            beacon = true,
            cmp = true,
            dap = {
                enabled = true,
                enable_ui = true, -- enable nvim-dap-ui
            },
            dap_ui = true,
            gitsigns = true,
            illuminate = {
                enabled = true,
                lsp = true,
            },
            indent_blankline = {
                enabled = true,
                colored_indent_levels = true,
            },
            leap = true,
            lsp_trouble = true,
            markdown = true,
            mason = true,
            mini = {
                enabled = true,
                indentscope_color = "", -- catppuccin color (eg. `lavender`) Default: text
            },
            native_lsp = {
                enabled = true,
                virtual_text = {
                    errors = { "italic" },
                    hints = { "italic" },
                    warnings = { "italic" },
                    information = { "italic" },
                },
                underlines = {
                    errors = { "underline" },
                    hints = { "underline" },
                    warnings = { "underline" },
                    information = { "underline" },
                },
                inlay_hints = {
                    background = true,
                },
            },
            neotest = true,
            noice = true,
            nvim_surround = true,
            nvimtree = true,
            overseer = true,
            rainbow_delimiters = true,
            snacks = true,
            telescope = {
                enabled = true,
                style = "nvchad",
            },
            treesitter = true,
            treesitter_context = true,
            ufo = true,
            which_key = true,
        },
    })

    vim.cmd([[colorscheme catppuccin]])
end

return M
