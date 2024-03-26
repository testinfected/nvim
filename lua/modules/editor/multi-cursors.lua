--[[
  Description: Multiple cursors for neovim
  See: https://github.com/brenton-leighton/multiple-cursors.nvim
]]
local M = {

	"brenton-leighton/multiple-cursors.nvim",
	version = "*", -- Use the latest tagged version
	keys = {
		{ "<C-Down>", "<Cmd>MultipleCursorsAddDown<CR>", mode = { "n", "i" } },
		{ "<C-j>", "<Cmd>MultipleCursorsAddDown<CR>" },
		{ "<C-Up>", "<Cmd>MultipleCursorsAddUp<CR>", mode = { "n", "i" } },
		{ "<C-k>", "<Cmd>MultipleCursorsAddUp<CR>" },
		{ "<C-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>", mode = { "n", "i" } },
		{ "<Leader>a", "<Cmd>MultipleCursorsAddMatches<CR>", mode = { "n", "x" } },
		{ "<Leader>A", "<Cmd>MultipleCursorsAddMatchesV<CR>", mode = { "n", "x" } },
	},
}

function M.config()
	require("multiple-cursors").setup({

		custom_key_maps = {
			-- w
			{
				{ "n", "x" }, "w",
				function(_, count)
					if count ~= 0 and vim.api.nvim_get_mode().mode == "n" then
						vim.cmd("normal! " .. count)
					end
					require("spider").motion("w")
				end,
			},

			-- e
			{
				{ "n", "x" }, "e",
				function(_, count)
					if count ~= 0 and vim.api.nvim_get_mode().mode == "n" then
						vim.cmd("normal! " .. count)
					end
					require("spider").motion("e")
				end,
			},

			-- b
			{
				{ "n", "x" }, "b",
				function(_, count)
					if count ~= 0 and vim.api.nvim_get_mode().mode == "n" then
						vim.cmd("normal! " .. count)
					end
					require("spider").motion("b")
				end,
			},
		},
	})
end

return M
