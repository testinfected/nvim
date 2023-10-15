--[[
  File: persisted.lua
  Description: Automated session management
  See: https://github.com/olimorris/persisted.nvim
]]

-- Lua
local M = {
  'olimorris/persisted.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-telescope/telescope.nvim',
  }
}

function M.config()
  require('persisted').setup {
    autosave = true, -- automatically save session files when exiting Neovim
    autoload = false, -- automatically load the session for the cwd on Neovim startup
    follow_cwd = true, -- change session file name to match current working directory if it changes
    use_git_branch = true,
    telescope = { -- options for the telescope extension
      reset_prompt_after_deletion = true, -- whether to reset prompt after session deleted
    },
    ignored_dirs = {
      '~/.config',
      '~/.local/nvim'
    },
  }

  require('telescope').load_extension('persisted')
end

return M
