--[[
  File: null-ls.lua
  Description: Use Neovim as a language server to inject LSP diagnostics, code actions, and more
  See: https://github.com/jose-elias-alvarez/null-ls.nvim
]]

local M = {
    'jay-babu/mason-null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        'williamboman/mason.nvim',
        'jose-elias-alvarez/null-ls.nvim',
        'nvim-lua/plenary.nvim',
    },
}

function M.config()
    local mason = require('mason-null-ls')
    local null_ls = require('null-ls')

    mason.setup {
        ensure_installed = { 'stylua', 'jq', 'black', 'prettier', 'flake8' },
        handlers = {
            function() end,                 -- disables automatic setup of all null-ls sources
            stylua = function(source_name, methods)
                null_ls.register(null_ls.builtins.formatting.stylua)
            end,
            shfmt = function(source_name, methods)
                -- custom logic
                mason.default_setup(source_name, methods)                                                                           -- to maintain default behavior
            end,
        },
    }

    null_ls.setup {
        sources = {
            null_ls.builtins.formatting.prettier.with {
                filetypes = {
                    'yaml',
                    'markdown',
                },
                extra_filetypes = { 'toml' },
                extra_args = { '--no-semi', '--single-quote', '--jsx-single-quote' }
            },
            null_ls.builtins.formatting.black.with { extra_args = { '--fast' } },
            null_ls.builtins.completion.spell,
            null_ls.builtins.diagnostics.markdownlint,
            --builtins.code_actions.gitsigns, -- we don't want blame line code action on every line of file
        }
    }
end

return M
