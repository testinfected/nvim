--[[
  Description: General-purpose motion plugin for Neovim
  See: https://github.com/ggandor/leap.nvim
]]

local M = {
    "ggandor/leap.nvim",
    event = "VeryLazy",
}

function M.config()
    -- Don't use leap in operator pending mode to avoid conflicts with nvim surround
    map = vim.keymap.set
    map({ 'n', 'x' }, 's', '<Plug>(leap-forward)')
    map({ 'n', 'x' }, 'S', '<Plug>(leap-backward)')
    map({ 'n', 'x' }, 'gs', '<Plug>(leap-from-window)')
end

return M
