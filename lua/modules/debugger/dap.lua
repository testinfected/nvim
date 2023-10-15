--[[
  File: dap.lua
  Description: Debug Adapter Protocol client
  See: https://github.com/mfussenegger/nvim-dap
]]

local M = {
    'mfussenegger/nvim-dap',
    event = 'VeryLazy',
}

local function ask(prompt)
    vim.fn.inputsave()
    local input = vim.fn.input(prompt .. ": ")
    vim.fn.inputrestore()
    return input
end

function M.config()
    local dap = require('dap')
    local sign = vim.fn.sign_define

-- Custom signs
sign('DapBreakpoint', { text = '●', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
sign('DapBreakpointCondition', { text = '●', texthl = 'DapBreakpointCondition', linehl = '', numhl = '' })
sign('DapBreakpointReject', { text = '●', texthl = 'DiagnosticSignHint', linehl = '', numhl = '' })
sign('DapLogPoint', { text = '◆', texthl = 'DapLogPoint', linehl = '', numhl = '' })
sign('DapStopped', { text = '→ ', texthl = 'DiagnosticSignWarn', linehl = 'Visual', numhl = 'DiagnosticSignWarn' })

-- Key mappings
local map, prefix = vim.keymap.set, '<leader>d'
    map('n', prefix .. 'c', dap.continue, { desc = "Continue/Start" })
    map('n', prefix .. 'd', dap.disconnect, { desc = "Disconnect" })
    map('n', prefix .. 'bb', dap.toggle_breakpoint, { desc = "Toggle" })
    map('n', prefix .. 'bc', function() dap.toggle_breakpoint(ask("Condition")) end, { desc = "Toggle conditionally" })
    map('n', prefix .. 'bh', function() dap.toggle_breakpoint(nil, ask("Hit number")) end, { desc = "Hit number" })
    map('n', prefix .. 'bl', function() dap.toggle_breakpoint(nil, nil, ask("Message")) end, { desc = "Log" })
end

return M
