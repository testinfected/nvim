--[[
  File: quickfix.lua
  Description: Prettier quickfix/location list windows
  See: https://github.com/yorickpeterse/nvim-pqf
]]

return {
  'yorickpeterse/nvim-pqf',
  event = 'VeryLazy',
  config = function()
    require('pqf').setup()
  end
}