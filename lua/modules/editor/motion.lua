--[[
  Description: General-purpose motion plugin for Neovim 
  See: https://github.com/ggandor/leap.nvim'
]]

local M = {
    'ggandor/leap.nvim',
    event = 'BufEnter'
}

function M.config()
    require 'leap'.setup {}
end

return M
