--[[
  File: which-key.lua
  Description: Displays a popup with possible key bindings
  See: https://github.com/folke/which-key.nvim
]]

local M = {
    'folke/which-key.nvim',
    event = 'VeryLazy'
}

function M.config()
    local wk = require('which-key')
    local icons = require('config.icons')
    wk.setup {
        window = {
            border = 'rounded', -- none, single, double, shadow
            align = 'center',
            margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
            padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
            winblend = 0,
        },
        layout = {
            height = { min = 4, max = 25 }, -- min and max height of the columns
            width = { min = 20, max = 50 }, -- min and max width of the columns
            spacing = 3, -- spacing between columns
            align = "left", -- align columns left, center or right
        },
        icons = {
			breadcrumb = icons.ui.Separator,
        }
    }

    wk.register {
        ['['] = {
            name = "+Navigate (backward)"
        },
        [']'] = {
            name = "+Navigate (forward)"
        },
        g = {
            name = "+Goto",
        },
        z = {
            name = "+Fold",
        },
        ['<c-w>'] = {
            name = "+Window",
        },
        ['<leader>'] = {
            name = "+User",
            c = {
                name = "+Code",
                d = {
                    name = "+Diagnostics",
                    _ = 'which_key_ignore'
                },
            },
            d = {
                name = "+Debug",
                b = {
                    name = "+Breakpoint",
                    _ = 'which_key_ignore'
                }
            },
            f = {
                name = "+Find",
            },
            g = {
                name = "+Git",
                g = {
                    name = "+Show",
                    _ = 'which_key_ignore'
                },
                t = {
                    name = "+Toggle",
                    _ = 'which_key_ignore'
                },
            },
            h = {
                name = "+Help",
                m = { function() vim.cmd [[WhichKey]] end, "Show mapping", },
                k = { function() local input = vim.fn.input "WhichKey: " vim.cmd([[WhichKey ]] .. input) end, "Lookup key..." }
            },
            o = {
                name = "+Overseer",
            },
            r = {
                name = "+Replace",
            },
            w = {
                name = "+Window",
            },
            t = {
                name = "+Test",
            },
            x = {
                name = "+Trouble",
            },
            ['\\'] = {
                name = "+Multi cursors",
            },

        }
    }
end

return M
