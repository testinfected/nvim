--[[
  Description: Improved LSP experience with rename, find references, incoming/outgoing calls, code hierarchy, outline and more
  See: https://github.com/nvimdev/lspsaga.nvim
]]

local M = {
  'nvimdev/lspsaga.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  event = 'LspAttach',
}

function M.config()
  require('lspsaga').setup {
    ui = {
      border = 'rounded',
      kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
    },
    code_action = {
      show_server_name = true, -- hide language server name
      extend_gitsigns = true, -- extend gitsigns plugin diff action
    },
    lightbulb = {
      virtual_text = false, -- show bulb at end of line
      sign = false
    },
    outline = {
      win_width = 50,
    },
    rename = {
        in_select = false,
    }
  }

  local map = vim.keymap.set
  map('n', '<leader>co', [[<Cmd>Lspsaga outline<CR>]], { desc = "Symbols outline" })
end

return M