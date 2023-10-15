--[[
  File: mason-dap.lua
  Description: Install debug adapters via Mason
  See: https://github.com/jay-babu/mason-nvim-dap.nvim
]]

local M = {
  'jay-babu/mason-nvim-dap.nvim',
  dependencies = {
    'williamboman/mason.nvim',
    'mfussenegger/nvim-dap',
  },
  event = 'VeryLazy',
  cmd = { 'DapInstall', 'DapUninstall' },
}

function M.config()
  require('mason-nvim-dap').setup {
    ensure_installed = {
      'python',
      'delve'
    }
  }
end

return M