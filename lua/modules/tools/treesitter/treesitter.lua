--[[
  Description: Configuration of tree-sitter in Neovim
  See: https://github.com/nvim-treesitter/nvim-treesitter
]]

local M = {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects'
  },
  build = [[:TSUpdate]],
  event = { 'BufReadPost', 'BufNewFile' },
}

local parsers = {
  'clojure',
  'cue',
  'go',
  'javascript',
  'lua',
  'markdown',
  'markdown_inline',
  'python',
  'ruby',
  'rust',
  'typescript',
  'vim'
}

function M.config()
  local treesitter = require('nvim-treesitter.configs')

  treesitter.setup {
    -- Needed parsers
    ensure_installed = parsers,
    -- Install all parsers synchronously
    sync_install = false,
    highlight = {
      -- Enabling highlight for all files
      enable = true,
      disable = {},
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn", -- set to `false` to disable one of the mappings
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
    },
    indent = {
      -- Disabling indentation for all files
      enable = false,
      disable = {},
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          -- see https://github.com/nvim-treesitter/nvim-treesitter-textobjects#built-in-textobjects
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
          ['aC'] = '@conditional.outer',
          ['iC'] = '@conditional.inner',
          ['ae'] = '@block.outer',
          ['ie'] = '@block.inner',
          ['al'] = '@loop.outer',
          ['il'] = '@loop.inner',
          ['is'] = '@statement.inner',
          ['as'] = '@statement.outer',
          ['ad'] = '@comment.outer',
          ['am'] = '@call.outer',
          ['im'] = '@call.inner'
        },
      },
      -- You can choose the select mode (default is charwise 'v')
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * method: eg 'v' or 'o'
      -- and should return the mode ('v', 'V', or '<c-v>') or a table
      -- mapping query_strings to modes.
      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@function.outer'] = 'V', -- linewise
        ['@class.outer'] = '<c-v>', -- blockwise
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },
    },
  }
end

return M
