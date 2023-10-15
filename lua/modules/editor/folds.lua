--[[
  File: ufo.lua
  Description: Modern looking folds
  See: https://github.com/kevinhwang91/nvim-ufo
]]

local M = {
  'kevinhwang91/nvim-ufo',
  dependencies = {
    'kevinhwang91/promise-async'
  },
  event = 'BufEnter'
}

local show_folded_lines_count = function(virtText, lnum, endLnum, width, truncate)
  local text = {}
  local suffix = (' 󰁂 %d '):format(endLnum - lnum)
  local currentWidth = 0
  local targetWidth = width - vim.fn.strdisplaywidth(suffix)

  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > currentWidth + chunkWidth then
      table.insert(text, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - currentWidth)
      local hlGroup = chunk[2]
      table.insert(text, { chunkText, hlGroup})
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if currentWidth + chunkWidth < targetWidth then
        suffix = suffix .. (' '):rep(targetWidth - currentWidth - chunkWidth)
      end
      break
    end
    currentWidth = currentWidth + chunkWidth
  end

  table.insert(text, { suffix, 'MoreMsg'})
  return text
end

function M.config()
  local ufo = require('ufo')

  vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
  vim.o.foldcolumn = "1" -- fold column with, 0 will hide it
  vim.o.foldlevel = 99 -- start with all folds opened
  vim.o.foldenable = true
  vim.o.foldmethod = "expr"
  vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

  ufo.setup {
    open_fold_hl_timeout = 150,
    close_fold_kinds = { 'imports', 'comment' },
    preview = {
      win_config = {
        border = 'rounded',
        winhighlight = 'Normal:Folded',
        winblend = 0
      },
      mappings = {
        scrollU = '<C-u>',
        scrollD = '<C-d>',
        jumpTop = '[',
        jumpBot = ']'
      }
    },
    fold_virt_text_handler = show_folded_lines_count
  }

  local map = vim.keymap.set
  map('n', 'zR', ufo.openAllFolds)
  map('n', 'zM', ufo.closeAllFolds)
  map('n', 'zr', ufo.openFoldsExceptKinds)
  map('n', 'zm', ufo.closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
  map('n', 'zp', ufo.peekFoldedLinesUnderCursor, { desc = "Preview fold content" }) -- closeAllFolds == closeFoldsWith(0)
end

return M