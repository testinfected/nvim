--[[
  File: gitsigns.lua
  Description: Super fast git decorations
  See: https://github.com/lewis6991/gitsigns.nvim
]]

local M = {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' }
}

function M.config()
  local git = require('gitsigns')

  git.setup {
    current_line_blame = true,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'right_align',
      delay = 1000,
      ignore_whitespace = false,
    },
    preview_config = {
      -- Options passed to nvim_open_win
      border = 'rounded',
      style = 'minimal',
      relative = 'cursor',
      row = 0,
      col = 1,
    },
    on_attach = function(bufnr)
      -- Navigation
      local next_hunk = function()
        if vim.wo.diff then return ']c' end vim.schedule(function() git.next_hunk() end)
        return '<Ignore>'
      end

      local prev_hunk = function()
        if vim.wo.diff then return '[c' end vim.schedule(function() git.prev_hunk() end)
        return '<Ignore>'
      end

      local telescope = require('telescope.builtin')
      local map, prefix = vim.keymap.set, '<leader>g'

      local function opts(values)
        values.buffer = bufnr
        return values
      end

      map('n', ']h', next_hunk, opts { desc = "Next hunk", expr = true })
      map('n', '[h', prev_hunk, opts { desc = "Previous hunk", expr = true })

      -- +git actions
      map('n', prefix .. 's', git.stage_hunk, opts { desc = "Stage hunk" })
      map('n', prefix .. 'r', git.reset_hunk, opts { desc = "Reset hunk" })
      map('n', prefix .. 'u', git.undo_stage_hunk, opts { desc = "Undo stage hunk" })
      map('n', prefix .. 'S', git.stage_buffer, opts { desc = "Stage buffer" })
      map('n', prefix .. 'R', git.reset_buffer, opts { desc = "Reset buffer" })
      map('n', prefix .. 'p', git.preview_hunk, opts { desc = "Preview hunk" })
      map('n', prefix .. 'd', git.diffthis, opts { desc = "View diff" })
      map('n', prefix .. 'd', function() git.diffthis('~') end, opts { desc = "View diff to head" })
      map('n', prefix .. 'b', git.blame_line, opts { desc = "Blame" })
      map('n', prefix .. 'B', function() git.blame_line { full = true } end, opts { desc = "Full blame" })
      map('n', prefix .. 'h', telescope.git_bcommits, opts { desc = "File history" })
      -- +show
      map('n', prefix .. 'gc', telescope.git_commits, { buffer = bufnr, desc = "Commits" })
      map('n', prefix .. 'gb', telescope.git_branches, { buffer = bufnr, desc = "Branches" })
      map('n', prefix .. 'gm', telescope.git_status, { buffer = bufnr, desc = "Changes" })
      map('n', prefix .. 'gs', telescope.git_stash, { buffer = bufnr, desc = "Stash" })
      -- +toggle
      map('n', prefix .. 'tb', git.toggle_current_line_blame, { buffer = bufnr, desc = "Current line blame" })
      map('n', prefix .. 'td', git.toggle_deleted, { buffer = bufnr, desc = "Deleted" })
      -- Text objects
      map({ 'o', 'x' }, 'ih', [[<Cmd>Gitsigns select_hunk]], { buffer = bufnr, desc = "Select hunk" })
    end
  }
end

return M
