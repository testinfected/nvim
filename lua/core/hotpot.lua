--[[
  Description: Clones hotpot (the fennel compiler) into the plugins directory if it missing
  See: https://github.com/rktjmp/hotpot.nvim
]]

local hotpot_path = vim.fn.stdpath('data') .. '/site/pack/paqs/start/hotpot.nvim'

if vim.fn.empty(vim.fn.glob(hotpot_path)) > 0 then
  print("Hotpot not installed, cloning to", hotpot_path)
  vim.fn.system { 'git', 'clone', 'https://github.com/rktjmp/hotpot.nvim', hotpot_path }
  vim.cmd('helptags' .. hotpot_path .. '/doc')
end