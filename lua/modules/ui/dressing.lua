
--[[
  File: dressing.lua
  Description: Improved vim.ui interfaces
  See: https://github.com/goolord/alpha-nvim
]]

local M = {
  'stevearc/dressing.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim'
  },
  event = 'VeryLazy'
}

function M.config()
  require('dressing').setup {
    input = {
      -- Default prompt string
      default_prompt = 'Input:',

      -- Can be 'left', 'right', or 'center'
      title_pos = 'left',

      -- These are passed to nvim_open_win
      border = 'rounded',
      -- 'editor' and 'win' will default to being centered
      relative = 'cursor',

      max_width = { 140, 0.9 },
      min_width = { 20, 0.2 },

      win_options = {
        -- Window transparency (0-100)
        winblend = 0,
        -- Disable line wrapping
        wrap = false,
        -- Indicator for when text exceeds window
        list = true,
        listchars = 'precedes:…,extends:…',
        -- Increase this for more context when text scrolls off the window
        sidescrolloff = 0,
      },

      -- Set to `false` to disable
      mappings = {
        n = {
          ['<Esc>'] = 'Close',
          ['<CR>'] = 'Confirm',
        },
        i = {
          ['<C-c>'] = 'Close',
          ['<CR>'] = 'Confirm',
          ['<Up>'] = 'HistoryPrev',
          ['<Down>'] = 'HistoryNext',
        },
      },
    },
    select = {
      backend = { 'builtin', 'nui' },

      -- Trim trailing `:` from prompt
      trim_prompt = true,

      -- Options for telescope selector
      -- These are passed into the telescope picker directly. Can be used like:
      -- telescope = require('telescope.themes').get_ivy({...})
      telescope = require('telescope.themes').get_dropdown(),

      -- Options for nui selector
      nui = {
        position = "50%",
        size = nil,
        relative = "editor",
        border = {
          style = "rounded",
        },
        buf_options = {
          swapfile = false,
          filetype = "DressingSelect",
        },
        win_options = {
          winblend = 0,
        },
        max_width = 80,
        max_height = 40,
        min_width = 40,
        min_height = 10,
      },

      -- Options for built-in selector
      builtin = {
        -- Display numbers for options and set up keymaps
        show_numbers = true,
        -- These are passed to nvim_open_win
        border = "rounded",
        -- 'editor' and 'win' will default to being centered
        relative = "editor",

        buf_options = {},
        win_options = {
          -- Window transparency (0-100)
          winblend = 0,
          cursorline = true,
          cursorlineopt = "both",
        },

        -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        -- the min_ and max_ options can be a list of mixed types.
        -- max_width = {140, 0.8} means "the lesser of 140 columns or 80% of total"
        width = nil,
        max_width = { 140, 0.8 },
        min_width = { 40, 0.2 },
        height = nil,
        max_height = 0.9,
        min_height = { 10, 0.2 },

        -- Set to `false` to disable
        mappings = {
          ["<Esc>"] = "Close",
          ["<C-c>"] = "Close",
          ["<CR>"] = "Confirm",
        },
      },
    }
  }
end

return M
