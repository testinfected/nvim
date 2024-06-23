--[[
  Description: Multiple cursors for neovim
  See: https://github.com/brenton-leighton/multiple-cursors.nvim
]]
local M = {

	"brenton-leighton/multiple-cursors.nvim",
	keys = {
		{
			"<C-j>",
			"<Cmd>MultipleCursorsAddDown<CR>",
			mode = { "n", "x" },
			desc = "Add cursor and move down",
		},
		{
			"<C-k>",
			"<Cmd>MultipleCursorsAddUp<CR>",
			mode = { "n", "x" },
			desc = "Add cursor and move up",
		},

		{
			"<C-Up>",
			"<Cmd>MultipleCursorsAddUp<CR>",
			mode = { "n", "i", "x" },
			desc = "Add cursor and move up",
		},
		{
			"<C-Down>",
			"<Cmd>MultipleCursorsAddDown<CR>",
			mode = { "n", "i", "x" },
			desc = "Add cursor and move down",
		},

		{
			"<C-LeftMouse>",
			"<Cmd>MultipleCursorsMouseAddDelete<CR>",
			mode = { "n", "i" },
			desc = "Add or remove cursor",
		},

		{
			"<Leader>a",
			"<Cmd>MultipleCursorsAddMatches<CR>",
			mode = { "n", "x" },
			desc = "Add cursors to nt word",
		},
		{
			"<Leader>A",
			"<Cmd>MultipleCursorsAddMatchesV<CR>",
			mode = { "n", "x" },
			desc = "Add cursors to current word in previous area",
		},

		{
			"<Leader>d",
			"<Cmd>MultipleCursorsAddJumpNextMatch<CR>",
			mode = { "n", "x" },
			desc = "Add cursor and jump to next cword",
		},
		{
			"<Leader>D",
			"<Cmd>MultipleCursorsJumpNextMatch<CR>",
			mode = { "n", "x" },
			desc = "Jump to next cword",
		},

		{
			"<Leader>l",
			"<Cmd>MultipleCursorsLock<CR>",
			mode = { "n", "x" },
			desc = "Lock virtual cursors",
		},
	},
}

function M.config()
	require("multiple-cursors").setup({
		-- nvim-autopairs plugin needs to be disabled while using multiple cursors:
		opts = {
			pre_hook = function()
				require("nvim-autopairs").disable()
			end,

			post_hook = function()
				require("nvim-autopairs").enable()
			end,
		},

		custom_key_maps = {
			-- For normal mode count must be set before nvim-spider's motion function is called:
			-- w
			{
				{ "n", "x" },
				"w",
				function(_, count)
					if count ~= 0 and vim.api.nvim_get_mode().mode == "n" then
						vim.cmd("normal! " .. count)
					end
					require("spider").motion("w")
				end,
			},

			-- e
			{
				{ "n", "x" },
				"e",
				function(_, count)
					if count ~= 0 and vim.api.nvim_get_mode().mode == "n" then
						vim.cmd("normal! " .. count)
					end
					require("spider").motion("e")
				end,
			},

			-- b
			{
				{ "n", "x" },
				"b",
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
