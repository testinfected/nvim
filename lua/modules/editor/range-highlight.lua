--[[
  File: range-highlight.lua
  Description: Hightlight ranges entered in commandline
  See: https://github.com/rktjmp/winston0410/range-highlight.nvim
]]

local M = {
  'winston0410/range-highlight.nvim',
  dependencies = {
    'winston0410/cmd-parser.nvim',
  },
  event = 'CmdlineEnter'
}

function M.config()
  require('range-highlight').setup()
end

return M