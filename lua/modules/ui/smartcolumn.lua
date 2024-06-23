--[[
Description: Hide your colorcolumn when unneeded.
See: https://github.com/m4xshen/smartcolumn.nvim
]]

local M = {
    "m4xshen/smartcolumn.nvim",
    event = "InsertEnter",
}

function M.config()
    require("smartcolumn").setup({
        colorcolumn = "80",
        disabled_filetypes = { "help", "text", "markdown" },
        custom_colorcolumn = {},
        scope = "file",
    })
end

return M
