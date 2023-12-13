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
	map("n", "<C-\\><C-j>", tmux.NvimTmuxNavigateDown, { desc = "Navigate down" })
	map("n", "<C-\\><C-k>", tmux.NvimTmuxNavigateUp, { desc = "Navigate up" })
	map("n", "<C-\\><C-l>", tmux.NvimTmuxNavigateRight, { desc = "Navigate right" })
	map("n", "<C-\\><C-h>", tmux.NvimTmuxNavigateLeft, { desc = "Navigate left" })
	map("n", "<C-\\><C-\\", tmux.NvimTmuxNavigateLastActive, { desc = "Navigate last" })
	map("n", "<C-\\><C-Space>", tmux.NvimTmuxNavigateNext, { desc = "Navigate next" })
end

return M
