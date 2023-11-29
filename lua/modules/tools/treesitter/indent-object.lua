--[[
  Description: Defines a new text object representing lines of code at the same indent level
  See: https://github.com/michaeljsmith/vim-indent-object
]]

return {
  'michaeljsmith/vim-indent-object',
  event = { 'BufReadPost', 'BufNewFile' },
}
