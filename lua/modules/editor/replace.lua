return {
	"gabrielpoca/replacer.nvim",
	event = "VeryLazy",
	keys = {
		{ "<leader>r", function() require("replacer").run() end, mode = 'n', desc = "Replace in quickfix list", },
	},
}
