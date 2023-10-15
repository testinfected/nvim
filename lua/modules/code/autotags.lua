--[[
  File: autotags.lua
  Description: Use treesitter to auto close and auto rename html tag
  See: https://github.com/windwp/nvim-ts-autotag
]]

local M = {
  'windwp/nvim-ts-autotag',
  event = 'InsertEnter'
}

function M.config()
  require('nvim-ts-autotag').setup()
end

return M
