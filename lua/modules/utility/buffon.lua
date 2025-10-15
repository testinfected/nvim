return {
	"francescarpi/buffon.nvim",
	branch = "main",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		keybindings = {
			goto_next_buffer = "false",
			goto_previous_buffer = "false",
		},
	},
	event = "VeryLazy",
}
