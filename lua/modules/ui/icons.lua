--[[
  File: nvim-dev-icons.lua
  Description: Adds icons to plugins
  See: https://github.com/nvim-tree/nvim-web-devicons
]]

local M = {
  'nvim-tree/nvim-web-devicons',
  event = 'VeryLazy',
}

function M.config()
  require('nvim-web-devicons').setup {
    color_icons = true,
    default = true,
  }
end

return M