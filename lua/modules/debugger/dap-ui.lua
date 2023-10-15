--[[
  File: dap-ui.lua
  Description: UI for nvim-dap
  See: https://github.com/rcarriga/nvim-dap-ui
]]

local M = {
  'rcarriga/nvim-dap-ui',
  dependencies = {
    'mfussenegger/nvim-dap'
  },
  event = 'VeryLazy',
}

function M.config()
  local dap, dapui = require('dap'), require('dapui')
  dap.listeners.after.event_initialized['dapui_config'] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated['dapui_config'] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited['dapui_config'] = function()
    dapui.close()
  end

  dapui.setup {
    expand_lines = true,
    layouts = {
      {
        elements = {
          { id = 'scopes', size = 0.33 },
          { id = 'breakpoints', size = 0.17 },
          { id = 'stacks', size = 0.25 },
          { id = 'watches', size = 0.25 },
        },
        size = 0.33,
        position = 'right',
      },
      {
        elements = {
          { id = 'repl', size = 0.45 },
          { id = 'console', size = 0.55 },
        },
        size = 0.27,
        position = 'bottom',
      },
    },
    floating = {
      max_height = 0.9,
      max_width = 0.5, -- Floats will be treated as percentage of your screen.
      border = 'rounded', -- Border style. Can be 'single', 'double' or 'rounded'
      mappings = {
        close = { 'q', '<Esc>' },
      },
    },
  }

  -- Key mappings
  local map, prefix = vim.keymap.set, '<leader>d'

  map({ 'n', 'v' }, prefix .. 'e', dapui.eval, { desc = "Evaluate", })
  map('n', prefix .. 'o', dapui.toggle, { desc = "Debugger", })
end

return M