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
        indent = {},
        scope = {
            enabled = false,
        },
        exclude = {

            filetypes = {
                "help",
                "lazy",
                "toggleterm",
                "NvimTree",
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
