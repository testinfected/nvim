--[[
  File: glow.lua
  Description: Markdown preview with Glow
  See: https://github.com/ellisonleao/glow.nvim
]]

local M = {
  'ellisonleao/glow.nvim',
  ft = { 'md' },
}

function M.config()
  return require('glow').setup {
    border = 'rounded'
  }
end

return M