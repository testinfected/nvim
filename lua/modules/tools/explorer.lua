--[[
  File: neotree.lua
  Description: Browse the file system and other tree like structures
  See: https://github.com/nvim-neo-tree/neo-tree.nvim
]]

local M = {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    -- Lua functions you don't want to write twice
    'nvim-lua/plenary.nvim',
    -- UI Component Library for Neovim
    'MunifTanjim/nui.nvim',
  },
  keys = {
    { '<leader>e', [[<Cmd>Neotree toggle<CR>]], desc = "File explorer" }
  }
}

function M.config()
  local neo_tree = require('neo-tree')
  local icons = require('config.icons')

  neo_tree.setup {
    default_component_configs = {
      icon = {
        folder_closed = icons.folder.Closed,
        folder_open = icons.folder.Open,
        folder_empty = icons.folder.Empty,
      },
      git_status = {
        symbols = {
          -- Change type
          added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
          modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
          deleted   = icons.git.FileDeleted,-- this can only be used in the git_status source
          renamed   = icons.git.FileRenamed,-- this can only be used in the git_status source
          -- Status type
          untracked = icons.git.FileUntracked,
          ignored   = icons.git.FileIgnored,
          unstaged  = icons.git.FileUnstaged,
          staged    = icons.git.FileStaged,
          conflict  = icons.git.FileConflict,
        }
      }
      -- defaults are fine
    }
  }
end

return M
