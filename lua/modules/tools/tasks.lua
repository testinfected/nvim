--[[
  Description: Task runner and job management
  See: https://github.com/stevearc/overseer.nvim
]]

local M = {
    'stevearc/overseer.nvim',
    dependencies = {
        'nvim-neotest/neotest'
    },
    event = 'VeryLazy',
}

function M.config()
    require('overseer').setup {
        task_list = {

            bindings = {
                ["?"] = "ShowHelp",
                ["g?"] = "ShowHelp",
                ["<CR>"] = "RunAction",
                ["<C-e>"] = "Edit",
                ["o"] = "Open",
                ["<C-v>"] = "OpenVsplit",
                ["<C-s>"] = "OpenSplit",
                ["<C-f>"] = "OpenFloat",
                ["x"] = "OpenQuickFix",
                ["p"] = "TogglePreview",
                [">"] = "IncreaseDetail",
                ["<"] = "DecreaseDetail",
                ["L"] = "IncreaseAllDetail",
                ["H"] = "DecreaseAllDetail",
                ["K"] = "ScrollOutputUp",
                ["J"] = "ScrollOutputDown",
                ["["] = "DecreaseWidth",
                ["]"] = "IncreaseWidth",
                ["{"] = "PrevTask",
                ["}"] = "NextTask",
            },
        },
        -- Configure the floating window used for task templates that require input
        -- and the floating window used for editing tasks
        form = {
            -- Set any window options here (e.g. winhighlight)
            win_opts = {
                winblend = 0,
            },
        },
        confirm = {
            win_opts = {
                winblend = 0,
            },
        },
        task_win = {
            win_opts = {
                winblend = 0,
            },
        },
        strategy = {
            "toggleterm",
            -- don't open the toggleterm window when a task starts
            open_on_start = false,
            -- mirrors the toggleterm "hidden" parameter, and keeps the task
            -- rendered in a toggleable window
            hidden = true,
        }
    }

    -- Run all neotest processes using overseer, see https://github.com/stevearc/overseer.nvim/blob/master/doc/third_party.md#neotest
    require('neotest').setup {
        consumers = {
            overseer = require('neotest.consumers.overseer'),
        },
    }

    local sidebar = require('overseer.task_list.sidebar')
    local map, prefix = vim.keymap.set, '<leader>r'
    map('n', prefix .. 't', [[<Cmd>OverseerToggle!<CR>]], { desc = "Toggle task list" })
    map('n', prefix .. 'o', [[<Cmd>OverseerOpen<CR>]], { desc = "Open task list" })
    map('n', prefix .. 'c', [[<Cmd>OverseerClose<CR>]], { desc = "Close task list" })
    map('n', prefix .. 'r', [[<Cmd>OverseerRun<CR>]], { desc = "Run task..." })
    map('n', prefix .. 'a', [[<Cmd>OverseerQuickAction<CR>]], { desc = "Quick action..." })
    map('n', prefix .. 'p', function() sidebar.get():toggle_preview() end, { desc = "Toggle task preview" })
end

return M
