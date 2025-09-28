--[[
  Description: Autopairs with support for multiple characters.
  See: https://github.com/windwp/nvim-autopairs
]]

return {
    "windwp/nvim-autopairs",
    -- don't load on InsertEnter event to avoid conflicts with multi-cursors
    event = "VeryLazy",
    config = function()
        require("nvim-autopairs").setup({
            -- Use treesitter
            check_ts = true,
        })
    end,
}
