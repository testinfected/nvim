--[[
Description: Delete Neovim buffers without losing window layout
See: https://github.com/famiu/bufdelete.nvim
]]

local M = {
    "famiu/bufdelete.nvim",
    keys = {
        -- Close buffer using <leader>q
        { "<leader>q", [[<Cmd>Bdelete<CR>]], mode = "n", desc = "Close buffer" },
    },
}

return M
