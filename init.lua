--[[
  File: init.lua
  Description: Entry point file for neovim
]]

require('core.hotpot') -- Fennel code goes to fnl/
require('config.options')
require('config.keymaps')

local modules = require('core.loader')
modules.load {
  'lsp',
  'completion',
  'debugger',
  'lang',
  'tools',
  'tools.telescope',
  'tools.treesitter',
  'editor',
  'code',
  'term',
  'ui',
}

-- vim:tabstop=2 shiftwidth=2 expandtab syntax=lua foldmethod=marker foldlevelstart=0 foldlevel=0