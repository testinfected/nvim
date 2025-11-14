return {
	{
		"francescarpi/buffon.nvim",
		branch = "main",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = {
			sort_buffers_by_loaded_status = true,
			new_buffer_position = "start",
			leader_key = ";",
			open = {
				by_default = false,
			},
			keybindings = {
				goto_previous_buffer = "<up>",
				goto_next_buffer = "<down>",
				move_buffer_up = "<s-up>",
				move_buffer_down = "<s-down>",
				move_buffer_top = "<left>",
				move_buffer_bottom = "<right>",
			},
		},
		event = "VeryLazy",
	},
}
