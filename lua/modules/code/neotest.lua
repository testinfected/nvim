--[[
  File: neotest.lua
  Description: framework for interacting with tests
  See: https://github.com/nvim-neotest/neotest
]]

local M = {
    'nvim-neotest/neotest',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
        'antoinemadec/FixCursorHold.nvim',
        'nvim-neotest/neotest-python',
        'nvim-neotest/neotest-go',
    },
    event = 'VeryLazy'
}

function M.config()
    -- get neotest namespace (api call creates or returns namespace)
    local neotest_ns = vim.api.nvim_create_namespace("neotest")
    vim.diagnostic.config({
        virtual_text = {
            format = function(diagnostic)
                local message =
                    diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
                return message
            end,
        },
    }, neotest_ns)

    local neotest = require('neotest')
    neotest.setup {
        adapters = {
            require('neotest-python'),
            require("neotest-go") {
                experimental = {
                    test_table = true,
                },
            }
        },
        quickfix = {
            open = function()
                vim.cmd [[Trouble quickfix]]
            end,
        },
    }

    -- Keymaps
    local map, prefix = vim.keymap.set, '<leader>t'
    map('n', prefix .. 'r', function() neotest.run.run() end, { desc = "Run Nearest" })
    map('n', prefix .. 'd', function() neotest.run.run { strategy = 'dap' } end, { desc = "Debug Nearest" })
    map('n', prefix .. 't', function() neotest.run.run(vim.fn.expand('%')) end, { desc = "Run File" })
    map('n', prefix .. 'a', function() neotest.run.run(vim.loop.cwd()) end, { desc = "Run All Test Files" })
    map('n', prefix .. 's', function() neotest.summary.toggle() end, { desc = "Toggle Summary" })
    map('n', prefix .. 'o', function() neotest.output.open { enter = true, auto_close = true } end,
        { desc = "Show Output" })
    map('n', prefix .. 'O', function() neotest.output_panel.toggle() end, { desc = "Toggle Output Panel" })
    map('n', prefix .. 'S', function() neotest.run.stop() end, { desc = "Stop" })
end

return M
