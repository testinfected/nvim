return {
	"chrisgrieser/nvim-spider",
	keys = {
		{ "w", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x" }, desc = "Move to next subword" },
		{
			"e",
			"<cmd>lua require('spider').motion('e')<CR>",
			mode = { "n", "o", "x" },
			desc = "Move to end of subword",
		},
		{
			"b",
			"<cmd>lua require('spider').motion('b')<CR>",
			mode = { "n", "o", "x" },
			desc = "Move to beginning of subword",
		},
		{
			"ge",
			"<cmd>lua require('spider').motion('ge')<CR>",
			mode = { "n", "o", "x" },
			desc = "Move to end of previous subword",
		},
	},

	config = function()
		-- default values
		require("spider").setup({
			skipInsignificantPunctuation = true,
			subwordMovement = true,
		})
		vim.keymap.set("i", "<C-f>", "<Esc>l<cmd>lua require('spider').motion('w')<CR>i")
		vim.keymap.set("i", "<C-b>", "<Esc><cmd>lua require('spider').motion('b')<CR>i")
	end,
}
