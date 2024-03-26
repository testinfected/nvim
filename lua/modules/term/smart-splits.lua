--[[
  Description: Smart, seamless, directional navigation and resizing between terminal multiplexer panes and nvim splits
  See: https://github.com/mrjones2014/smart-splits.nvim
]]

local M = {
	"mrjones2014/smart-splits.nvim",
	lazy = false,
}

function M.config()
	local splits = require("smart-splits")
	splits.setup()

	local map = vim.keymap.set
	-- these keymaps will also accept a range,
	-- for example `10<C-Space>H` will `resize_left` by `(10 * config.default_amount)`
	map("n", "<C-Space>H", splits.resize_left)
	map("n", "<C-Space>J", splits.resize_down)
	map("n", "<C-Space>K", splits.resize_up)
	map("n", "<C-Space>L", splits.resize_right)
	-- moving between splits
	map("n", "<C-Space><C-h>", splits.move_cursor_left)
	map("n", "<C-Space><C-j>", splits.move_cursor_down)
	map("n", "<C-Space><C-k>", splits.move_cursor_up)
	map("n", "<C-Space><C-l>", splits.move_cursor_right)
	map("n", "<C-Space><C-\\>", splits.move_cursor_previous)
	-- swapping buffers between windows
	-- vim.keymap.set("n", "<leader><leader>h", splits.swap_buf_left)
	-- vim.keymap.set("n", "<leader><leader>j", splits.swap_buf_down)
	-- vim.keymap.set("n", "<leader><leader>k", splits.swap_buf_up)
	-- vim.keymap.set("n", "<leader><leader>l", splits.swap_buf_right)
end

return M
