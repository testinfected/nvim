--[[
  Description: Indent guides for Neovim
  See: https://github.com/lukas-reineke/indent-blankline.nvim
]]

local M = {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
}

function M.config()
    require("ibl").setup({
        indent = {
            char = { '', '┊', '┆', '¦', '|', '¦', '┆', '┊', '' },
        },
        whitespace = {
            remove_blankline_trail = true,
        },
        scope = {
            enabled = true,
            char = '┃',
            show_start = true,
        },
        exclude = {
            filetypes = {
                "help",
                "lazy",
                "toggleterm",
                "NvimTree",
                "guihua",
                "Overseer",
            },

            buftypes = {
                "terminal",
                "nofile",
            },
        },
    })
end

return M
