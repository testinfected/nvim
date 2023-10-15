--[[
  File: project.lua
  Description: Project management solution for neovim
  See: https://github.com/ahmedkhalf/project.nvim
]]

local M = {
  'ahmedkhalf/project.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  keys = {
    { '<leader>,', [[<Cmd>Telescope projects<CR>]], desc = "Project" },
  },
  event = 'VeryLazy',
}

function M.config()
  require('project_nvim').setup {
    -- detection_methods = { 'lsp', 'pattern' }, -- NOTE: lsp detection will get annoying with multiple langs in one project
    detection_methods = { 'pattern' },

    -- patterns used to detect root dir, when **'pattern'** is in detection_methods
    patterns = { '.git', 'Makefile', 'package.json', 'go.mod', 'cargo.toml' },
  }

  require('telescope').load_extension('projects')
end

return M