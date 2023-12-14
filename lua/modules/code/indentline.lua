--[[
  File: indentline.lua
  Description: Indent guides for Neovim
  See: https://github.com/lukas-reineke/indent-blankline.nvim
]]

local M = {
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufEnter',
}

function M.config()
    require('ibl').setup {
        indent = {
        },
        scope = {

        },
        exclude = {

            filetypes = {
                'help',
                'lazy',
                'toggleterm',
                'NeoTree',
            },

            buftypes = {
                'terminal',
                'nofile',
            },
        },
    }
end

return M
