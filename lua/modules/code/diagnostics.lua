--[[
  File: trouble.lua
  Description: A pretty diagnostics, references, telescope results, quickfix and location list
  See: https://github.com/folke/trouble.nvim
]]

local M = {
  'folke/trouble.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  event = 'BufEnter',
}

local function set_sign_icons(opts)
  opts = opts or {}

  local sign = function(args)
    if opts[args.name] == nil then
      return
    end

    vim.fn.sign_define(args.hl, {
      texthl = args.hl,
      text = opts[args.name],
      numhl = ''
    })
  end

  sign({ name = 'error', hl = 'DiagnosticSignError' })
  sign({ name = 'warn', hl = 'DiagnosticSignWarn' })
  sign({ name = 'hint', hl = 'DiagnosticSignHint' })
  sign({ name = 'info', hl = 'DiagnosticSignInfo' })
end

function M.config()
  require('trouble').setup()

  local telescope = require('trouble.providers.telescope')
  require('telescope').setup {
    defaults = {
      mappings = {
        i = { ['<c-t>'] = telescope.open_with_trouble },
        n = { ['<c-t>'] = telescope.open_with_trouble },
      },
    },
  }

  -- Keymaps
  local trouble = require('trouble')

  local map, prefix = vim.keymap.set, '<leader>x'
  map('n', prefix .. 'x', trouble.open, { desc = "Open" })
  map('n', prefix .. 'w', function() trouble.open('workspace_diagnostics') end, { desc = "Workspace diagnostics" })
  map('n', prefix .. 'd', function() trouble.open('document_diagnostics') end, { desc = "Document diagnostics" })
  map('n', prefix .. 'q', function() trouble.open('quickfix') end, { desc = "Quickfix" })
  map('n', prefix .. 'l', function() trouble.open('loclist') end, { desc = "Locations" })
  map('n', prefix .. 'r', function() trouble.open('lsp_references') end, { desc = "References" })

  -- Custom sign icons
  local icons = require('config.icons')
  set_sign_icons({
    error = icons.diagnostics.Error,
    warn = icons.diagnostics.Warning,
    hint = icons.diagnostics.Hint,
    info = icons.diagnostics.Info
  })
end

return M
