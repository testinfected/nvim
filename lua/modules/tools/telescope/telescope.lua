--[[
  File: telescope.lua
  Description: Fuzzy finder over lists
  See: https://github.com/nvim-telescope/telescope.nvim
]]

local M = {
  'nvim-telescope/telescope.nvim',
  version = '0.1.2',
  dependencies = {
    'nvim-lua/popup.nvim',
    'nvim-lua/plenary.nvim',
    {
      -- much faster fzf than its lua counterpart
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
    },
  },
  event = 'VeryLazy'
}

local function setup_keymaps()
  local builtin = require('telescope.builtin')

  local map = vim.keymap.set
  map('n', '<leader> ', builtin.find_files, { desc = "Find file" })
  map('n', '<leader>;', builtin.buffers, { desc = "Select buffer" })
  map('n', '<leader>/', builtin.live_grep, { desc = "Search everywhere" })
  map('n', '<leader>:', builtin.command_history, { desc = "Search command history" })
  map('n', '<leader>*', builtin.grep_string, { desc = "Find word under cursor" })

  -- +buffer
  map('n', '<leader>bf', builtin.find_files, { desc = "Open from workspace" })
  map('n', '<leader>bo', builtin.git_files, { desc = "Open from project" })
  map('n', '<leader>br', builtin.oldfiles, { desc = "Open recent" })
  map('n', '<leader>bs', function() builtin.buffers({ show_all_buffers = true }) end, { desc = "Select" })

  -- +Find
  map('n', '<leader>fb', builtin.current_buffer_fuzzy_find, { desc = "Text in current buffer" })
  map('n', '<leader>fc', builtin.command_history, { desc = "Recent command" })
  map('n', '<leader>fm', builtin.marks, { desc = "Mark" })
  map('n', '<leader>fr', builtin.resume, { desc = "Resume last search" })
  map('n', '<leader>ft', builtin.live_grep, { desc = "Text everywhere" })
  map('n', '<leader>fw', builtin.grep_string, { desc = "Word under cursor" })

  -- +help
  map('n', '<leader>hc', builtin.commands, { desc = "Show available commands" })
  map('n', '<leader>hk', builtin.keymaps, { desc = "Show keymaps" })
  map('n', '<leader>ho', builtin.vim_options, { desc = "Show options" })
  map('n', '<leader>hh', builtin.help_tags, { desc = "Show help tags" })
  map('n', '<leader>hH', builtin.highlights, { desc = "Show highlight groups" })
end

function M.config()
  local telescope = require('telescope')

  telescope.setup {
    defaults = require('telescope.themes').get_dropdown {
      -- Default configuration for telescope goes here:
      -- config_key = value,
    },
    pickers = {
      -- Default configuration for builtin pickers goes here:
      -- picker_name = {
      --   picker_config_key = value,
      --   ...
      -- }
      -- Now the picker_config_key will be applied every time you call this
      -- builtin picker
    },
    extensions = {
      -- Your extension configuration goes here:
      -- extension_name = {
      --   extension_config_key =: value,
      -- }
      -- please take a look at the readme of the extension you want to configure
    }
  }

  -- Super fast fuzzy find
  telescope.load_extension('fzf')

  -- Keybindings
  setup_keymaps()
end

return M