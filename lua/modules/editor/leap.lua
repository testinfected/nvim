--[[
  Description: General-purpose motion plugin for Neovim
  See: https://github.com/ggandor/leap.nvim
]]

local M = {
    "ggandor/leap.nvim",
    event = "VeryLazy",
}

function M.config()
    require("leap").add_default_mappings()

    -- Avoid conflicts with vim-surround
    vim.g["surround_no_mappings"] = 1
    local map = vim.keymap.set
    -- Just the defaults copied here.
    map("n", "ds", "<Plug>Dsurround")
    map("n", "cs", "<Plug>Csurround")
    map("n", "cS", "<Plug>CSurround")
    map("n", "ys", "<Plug>Ysurround")
    map("n", "yS", "<Plug>YSurround")
    map("n", "yss", "<Plug>Yssurround")
    map("n", "ySs", "<Plug>YSsurround")
    map("n", "ySS", "<Plug>YSsurround")

    -- The conflicting ones. Note that `<Plug>(leap-cross-window)`
    -- _does_ work in Visual mode, if jumping to the same buffer,
    -- so in theory, `gs` could be useful for Leap too...
    map("x", "gs", "<Plug>VSurround")
    map("x", "gS", "<Plug>VgSurround")
end

return M
