--[[
  File: comments.lua
  Description: Adds a new operator to toggle comments in code
  See: https://github.com/numToStr/Comment.nvim
]]

-- :help comment-nvim
return {
  'numToStr/Comment.nvim',
  event = { 'BufRead', 'BufNewFile' },
  config = true
}
