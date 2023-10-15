--[[
  File: zen.lua
  Description: Clean and elegant distraction-free writing
  See: https://github.com/pocco81/true-zen.nvim
]]

local M = {
  'pocco81/true-zen.nvim',
  keys = {
    { '<leader>s ', [[<Cmd>TZFocus<CR>]], desc = "Maximize" },
    { '<leader>sf', [[<Cmd>TZNarrow<CR>]], desc = "Focus selection", mode = { 'v' } },
    { '<leader>sf', [[<Cmd>TZAtaraxis<CR>]], desc = "Focus (zen mode)", mode = { 'n' } },
    { '<leader>sm', [[<Cmd>TZMinimalist<CR>]], desc = "Minimalist mode" },
  },
}

function M.config()
  require('true-zen').setup {
    modes = { -- configurations per mode
      minimalist = {
        options = { -- options to be disabled when entering Minimalist mode
          number = true,
          relativenumber = true,
          showtabline = 0,
          signcolumn = "no",
          statusline = "",
          cmdheight = 0,
          laststatus = 0,
          showcmd = false,
          showmode = false,
          ruler = false,
          numberwidth = 1
        },
      },
    },
    integrations = {
      tmux = false, -- hide tmux status bar in (minimalist, ataraxis)
      lualine = false -- hide nvim-lualine (ataraxis)
    },
  }
end

return M