--[[
  File: cmp-dap.lua
  Description: nvim-cmp source for nvim-dap REPL and nvim-dap-ui buffers
  See: https://github.com/rcarriga/cmp-dap
]]

local M = {
  "rcarriga/cmp-dap",
  dependencies = {
    'mfussenegger/nvim-dap',
    'hrsh7th/nvim-cmp'
  },
}

function M.config()
  local cmp = require('cmp')
  cmp.setup {
    enabled = function()
      return vim.api.nvim_buf_get_option(0, 'buftype') ~= 'prompt'
        or require('cmp_dap').is_dap_buffer()
    end
  }

  cmp.setup.filetype({ 'dap-repl', 'dapui_watches', 'dapui_hover' }, {
    sources = {
      { name = 'dap' },
    },
  })
end

return M