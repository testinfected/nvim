--[[
  Description: Add a bit of reactivity to your Neovim experience
  See: https://github.com/rasulomaroff/reactive.nvim
 ]]

return {
    "rasulomaroff/reactive.nvim",
    event = "VeryLazy",
    config = function()
        require("reactive").setup({
            load = { "catppuccin-mocha-cursor", "catppuccin-mocha-cursorline" },
        })
    end,
}
