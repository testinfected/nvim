--[[
  Description: Seamless navigation between tmux panes and vim splits
  See: https://github.com/alexghergh/nvim-tmux-navigation
]]

local M = {
	"alexghergh/nvim-tmux-navigation",
    lazy = false,
}

function M.config()
    local tmux = require('nvim-tmux-navigation')
	local map = vim.keymap.set
	map("n", "<C-Space><C-j>", tmux.NvimTmuxNavigateDown, { desc = "Navigate down" })
	map("n", "<C-Space><C-k>", tmux.NvimTmuxNavigateUp, { desc = "Navigate up" })
	map("n", "<C-Space><C-l>", tmux.NvimTmuxNavigateRight, { desc = "Navigate right" })
	map("n", "<C-Space><C-h>", tmux.NvimTmuxNavigateLeft, { desc = "Navigate left" })
	map("n", "<C-Space><C-\\>", tmux.NvimTmuxNavigateLastActive, { desc = "Navigate last" })
	map("n", "<C-Space><C-Space>", tmux.NvimTmuxNavigateNext, { desc = "Navigate next" })
end

return M
