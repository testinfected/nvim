--[[
  Description: Tag important files
  See: https://github.com/cbochs/grapple.nvim
]]

local M = {
    "cbochs/grapple.nvim",
    dependencies = {
        { "nvim-tree/nvim-web-devicons", lazy = true },
    },
    event = { "BufReadPost", "BufNewFile" },
    cmd = "Grapple",
    keys = {
        { "<leader>wt", "<cmd>Grapple toggle<cr>",          desc = "Tag/Untag" },
        { "<leader>wp", "<cmd>Grapple toggle_tags<cr>",     desc = "Pick tagged" },
        { "<leader>wk", "<cmd>Grapple cycle_tags next<cr>", desc = "Next tagged" },
        { "<leader>wj", "<cmd>Grapple cycle_tags prev<cr>", desc = "Previous tagged" },
    },
}

function M.config()
    require("grapple").setup({
        win_opts = {
            -- Can be fractional
            width = 80,
            height = 12,
            row = 0.5,
            col = 0.5,

            relative = "editor",
            border = "rounded",
            focusable = false,
            style = "minimal",
            title_pos = "center",

            -- Custom: fallback title for Grapple windows
            title = "Grapple",

            -- Custom: adds padding around window title
            title_padding = " ",
        },
    })
end

return M
