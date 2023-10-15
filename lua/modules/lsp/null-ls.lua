--[[
  File: null-ls.lua
  Description: Use Neovim as a language server to inject LSP diagnostics, code actions, and more
  See: https://github.com/jose-elias-alvarez/null-ls.nvim
]]

local M = {
  'jose-elias-alvarez/null-ls.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  event = 'BufReadPre'
}

function M.config()
  local null_ls = require('null-ls')
  local builtins = null_ls.builtins

  null_ls.setup {
    sources = {
      builtins.formatting.stylua,
      builtins.formatting.prettier.with {
        filetypes = {
          'yaml',
          'markdown',
        },
        extra_filetypes = { 'toml' },
        extra_args = { '--no-semi', '--single-quote', '--jsx-single-quote' }
      },
      builtins.formatting.black.with { extra_args = { '--fast' } },
      builtins.completion.spell,
      builtins.diagnostics.markdownlint,
      --builtins.code_actions.gitsigns, -- we don't want blame line code action on every line of file
    },
  }
end

return M