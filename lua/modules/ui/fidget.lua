--[[
  Description: Non-intrusive notification and LSP progress messages
  See: https://github.com/j-hui/fidget.nvim
]]

local M = {
  "j-hui/fidget.nvim",
  event = "VeryLazy",
}

function M.config()
    require('fidget').setup({
        notification = {
            override_vim_notify = true,  -- Automatically override vim.notify() with Fidget
            window = {
                winblend = 0,
            }
        },
        progress = {
            display = {
                done_icon = require('config.icons').ui.Checkmark
            }
        }
    })
end

return M
