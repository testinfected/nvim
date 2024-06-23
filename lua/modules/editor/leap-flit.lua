--[[
  Description: Enhanced f/t motions for Leap
  See: https://github.com/ggandor/flit.nvim
]]

local M = {
    "ggandor/flit.nvim",
    event = "VeryLazy",
}

function M.config()
    -- We just use defaults
    require("flit").setup({
        keys = { f = "f", F = "F", t = "t", T = "T" },
        -- A string like "nv", "nvo", "o", etc.
        labeled_modes = "v",
        multiline = true,
        -- Like `leap`s similar argument (call-specific overrides).
        -- E.g.: opts = { equivalence_classes = {} }
        opts = {},
    })
end

return M
