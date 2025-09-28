--[[
  Description: General-purpose motion plugin for Neovim
  See: https://github.com/ggandor/leap.nvim
]]

return {
    "ggandor/leap.nvim",
    event = "VeryLazy",
    config = function()
        -- Don't use leap in operator pending mode to avoid conflicts with nvim surround
        local map = vim.keymap.set
        map({ "n", "x" }, "s", "<Plug>(leap-forward)")
        map({ "n", "x" }, "S", "<Plug>(leap-backward)")
        map({ "n", "x" }, "gs", "<Plug>(leap-from-window)")
    end,
}
