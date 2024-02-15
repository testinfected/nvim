--[[
  Description: Add a bit of reactivity to your Neovim experience
  See: https://github.com/rasulomaroff/reactive.nvim
 ]]

local M = {
    "rasulomaroff/reactive.nvim",
    event = "VeryLazy",
}

function M.config()
    require("reactive").setup({
        load = { "catppuccin-mocha-cursor", "catppuccin-mocha-cursorline" },
    })
end

return M
