-- time-machine.lua
return {
	"y3owk1n/time-machine.nvim",
	cmd = {
		"TimeMachineToggle",
		"TimeMachinePurgeBuffer",
		"TimeMachinePurgeAll",
		"TimeMachineLogShow",
		"TimeMachineLogClear",
	},
	opts = {},
	keys = {
		{
			"<leader>h",
			"",
			desc = "History",
		},
		{
			"<leader>ht",
			"<cmd>TimeMachineToggle<cr>",
			desc = "Toggle Tree",
		},
		{
			"<leader>hx",
			"<cmd>TimeMachinePurgeCurrent<cr>",
			desc = "Purge current",
		},
		{
			"<leader>hX",
			"<cmd>TimeMachinePurgeAll<cr>",
			desc = "Purge all",
		},
		{
			"<leader>hl",
			"<cmd>TimeMachineLogShow<cr>",
			desc = "Show log",
		},
	},
}
