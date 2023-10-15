--[[
  File: sad.lua
  Description: Project-wide find and replace plugin
  See: https://github.com/ray-x/sad.nvim
]]

local M = {
  'ray-x/sad.nvim',
  dependencies = {
    { 'ray-x/guihua.lua', build = 'cd lua/fzy && make' }
  },
  keys = {
    { '<leader>&', [[<Cmd>Sad<CR>]], desc = "Replace word under cursor", mode = { 'n', 'v' } }
  },
  cmd = { 'Sad' }
}

function M.config()
  require('sad').setup {
    debug = false, -- print debug info
    diff = 'delta', -- you can use `less`, `diff-so-fancy`
    ls_file = 'fd', -- also git ls-files
    exact = false, -- exact match
    vsplit = false, -- split sad window the screen vertically, when set to number
    -- it is a threadhold when window is larger than the threshold sad will split vertically,
    height_ratio = 0.6, -- height ratio of sad window when split horizontally
    width_ratio = 0.6, -- height ratio of sad window when split vertically
  }
end

return M