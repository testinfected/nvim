--[[
Description: Hide your colorcolumn when unneeded.
See: https://github.com/m4xshen/smartcolumn.nvim
]]

return {
    "m4xshen/smartcolumn.nvim",
    event = "InsertEnter",
    config = function()
        require("smartcolumn").setup({
            colorcolumn = "80",
            disabled_filetypes = { "help", "text", "markdown" },
            custom_colorcolumn = {},
            scope = "file",
        })
    end,
}
