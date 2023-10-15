--[[
  File: mason.lua
  Description: Portable package manager to install and manage LSP servers, DAP servers, linters, and formatters.
  See: https://github.com/williamboman/mason.nvim
]]

local M = {
  'williamboman/mason.nvim',
  build = [[:MasonUpdate]],
  dependencies = {
    'neovim/nvim-lspconfig',
    'williamboman/mason-lspconfig.nvim',
    'hrsh7th/cmp-nvim-lsp',
  },
  -- Load Mason immediately, it needs to be ready before LSP
  lazy = false,
}

local servers = {
  'dagger', -- LSP for CUE
  'bashls', -- LSP for Bash
  'clojure_lsp', -- LSP for Clojure
  'cssls', -- LSP for CSS
  'dockerls', -- LSP for Docker (exl. Docker Compose)
  'emmet_ls', -- LSP for Emmet (Vue, HTML, CSS)
  --'fennel_language_server', -- LSP for Fennel
  'gopls', -- LSP for Go
  'gradle_ls', -- LSP for Gradle
  'html', -- LSP for HTML
  'lua_ls', -- LSP for Lua language
  'marksman', -- LSP for Markdown
  'pyright', -- LSP for Python
  -- 'ruby_ls',                -- LSP for Ruby
  'rust_analyzer',          -- LSP for Rust
  'sqlls', -- LSP for SQL
  'taplo', -- LSP for TOML
  'lemminx', -- LSP for XML
  'tsserver', -- LSP for Typescript and Javascript
  'yamlls', -- LSP for YAML
}

function M.config()
  require('mason').setup {
    ui = {
      border = 'rounded'
    }
  }

  local mason_lspconfig = require('mason-lspconfig')
  mason_lspconfig.setup {
    ensure_installed = servers
  }

  --Setup every needed language server in lspconfig
  local lspconfig = require('lspconfig')
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
  }

  mason_lspconfig.setup_handlers {
    function(server_name)
      lspconfig[server_name].setup {
        capabilities = capabilities,
      }
    end,
  }
end

return M
