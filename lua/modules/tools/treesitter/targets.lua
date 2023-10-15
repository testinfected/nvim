--[[
  File: targets.lua
  Description: Adds various text objects to give more targets to operate on
  See: https://github.com/wellle/targets.vim
]]

-- :help targets-settings
-- see cheatsheet: https://github.com/wellle/targets.vim/blob/master/cheatsheet.md
return {
  'wellle/targets.vim',
  event = { 'BufReadPost', 'BufNewFile' },
}