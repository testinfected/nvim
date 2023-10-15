--[[
  File: notifier.lua
  Description: Non-intrusive notification system for neovim
  See: https://github.com/vigoux/notifier.nvim
]]

local M = {
  'vigoux/notifier.nvim',
  event = 'VeryLazy'
}

function M.config()
  require('notifier').setup()
end

return M