--[[
  File: lsp.lua
  Description: Quickstart configs for Nvim LSP
  See: https://github.com/neovim/nvim-lspconfig
]]

local M = {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre' },
  dependencies = {
    {
      -- Description: VSCode-like pictograms for neovim built-in lsp
      -- See: https://github.com/onsails/lspkind.nvim
      'onsails/lspkind.nvim',
      'nvim-telescope/telescope.nvim',
      'nvimdev/lspsaga.nvim', -- incremental rename with preview
    },
  },
}

local function setup_keymaps(bufnr)
  local function opts(values)
    values.buffer = bufnr
    return values
  end

  local telescope = require('telescope.builtin')
  local map, prefix = vim.keymap.set, '<leader>c'

  --- Hover
  map('n', 'K', [[<cmd]Lspsaga hover_doc<cr>]], opts { desc = "Quick documentation" })
  -- Code references
  map('n', 'gd', [[<<Cmd>Lspsaga goto_definition<CR>]], opts { desc = "Definition" })
  map('n', 'gD', [[<<Cmd>Lspsaga peek_definition<CR>]], opts { desc = "Peek definition" })
  map('n', 'gr', [[<<Cmd>Lspsaga finder<CR>]], opts { desc = "References" })
  map('n', 'gt', [[<<Cmd>Lspsaga goto_type_definition<CR>]], opts { desc = "Type definition" })
  map('n', 'gT', [[<<Cmd>Lspsaga peek_type_definition<CR>]], opts { desc = "Peek type definition" })
  map('n', 'gI', [[<<Cmd>Lspsaga incoming_calls<CR>]], opts { desc = "Incoming calls" })
  map('n', 'gO', [[<<Cmd>Lspsaga outgoing_calls<CR>]], opts { desc = "Incoming calls" })

  map('n', 'gs', vim.lsp.buf.signature_help, opts { desc = "Signature" })

  -- Navigate diagnostics
  map('n', ']d', [[<<Cmd>Lspsaga diagnostic_jump_next<CR>]], opts { desc = "Next diagnostic" })
  map('n', '[d', [[<<Cmd>Lspsaga diagnostic_jump_prev<CR>]], opts { desc = "Previous diagnostic" })

  -- Code actions
  map('n', prefix .. 'a', [[<cmd>Lspsaga code_action<cr>]], opts { desc = "Code action" })
  map('n', prefix .. 'f', function() vim.lsp.buf.format { async = true } end, opts { desc = "Format document" })
  map('n', prefix .. 'l', vim.lsp.codelens.run, opts { desc = "CodeLens Action" })
  map('n', prefix .. 'q', telescope.quickfix, opts { desc = "Quickfix" })
  map('n', prefix .. 'r', [[<<cmd>Lspsaga rename<cr>]], opts { desc = "Rename..." })
  map('n', prefix .. 's', telescope.lsp_document_symbols, opts { desc = "Document symbols" })
  map('n', prefix .. 'S', telescope.lsp_dynamic_workspace_symbols, opts { desc = "Workspace Symbols" })

  -- Diagnostic
  map('n', prefix .. 'dc', [[<<cmd>Lspsaga show_cursor_diagnostics<cr>]], opts { desc = "Cursor diagnostics" })
  map('n', prefix .. 'dl', [[<<cmd>Lspsaga show_line_diagnostics<cr>]], opts { desc = "Line diagnostics" })
  map('n', prefix .. 'df', [[<<cmd>Lspsaga show_buf_diagnostics<cr>]], opts { desc = "File diagnostics" })
  map('n', prefix .. 'dw', [[<<cmd>Lspsaga show_workspace_diagnostics<cr>]], opts { desc = "Workspace diagnostics" })

  -- Visual mode range actions
  map('v', prefix .. 'a', [[<cmd>Lspsaga code_action<cr>]], opts { desc = "Act on selection" })
  map('v', prefix .. 'f', vim.lsp.buf.format, opts { desc = "Format selection" })
end

function M.config()
  -- I like rounded borders obviously
  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover, {
      border = 'rounded'
    }
  )
  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help, {
      border = 'rounded'
    }
  )
  vim.diagnostic.config {
    float = { border = 'rounded' }
  }

  -- When lsp server activates...
  vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
      -- setup LSP symbols
      require('lspkind').init {
        mode = 'symbol',
        preset = 'default',
        symbol_map = require('config.icons').kind
      }

      -- bind keys
      setup_keymaps(event.buf)
    end
  })
end

return M
