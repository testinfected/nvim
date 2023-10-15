 --[[
  File: file-browser.lua
  Description: File browser extension for telescope.nvim
  See: https://github.com/nvim-telescope/telescope-file-browser.nvim
]]

local M = {
  'nvim-telescope/telescope-file-browser.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  keys = {
    { '<leader>.', [[<Cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>]], desc = "Browse files" },
    { '<leader>bb', [[<Cmd>Telescope file_browser<CR>]], desc = "Browse project" },
  },
  event = { 'VeryLazy' },
}

function M.config()
  local telescope = require('telescope')

  telescope.setup {
    extensions = {
      file_browser = {
        -- disables netrw and use telescope-file-browser in its place
        hijack_netrw = true,
        mappings = {
          ['i'] = {
            -- your custom insert mode mappings
          },
          ['n'] = {
            -- your custom normal mode mappings
          },
        },
      }
    }
  }

  telescope.load_extension('file_browser')
end

return M