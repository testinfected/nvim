--[[
  File: toggleterm.lua
  Description: Easily manage multiple terminal window
  See: https://github.com/akinsho/toggleterm.nvim
]]


local M = {
  'akinsho/toggleterm.nvim',
  event = 'VeryLazy',
}

function M.config()
  local toggleterm = require('toggleterm')
  toggleterm.setup {
    open_mapping = [[<leader>\]],
    insert_mappings = false,
    start_in_insert = true,
    direction = 'float',
    shade_terminals = true,
    float_opts = {
      border = 'curved'
    }
  }

  -- Keymaps
  local Terminal = require('toggleterm.terminal').Terminal
  local lazygit = Terminal:new { cmd = 'lazygit', hidden = true }
  vim.keymap.set('n', '<leader>gc', function() lazygit:toggle() end, { desc = "Commit" })
end

return M
