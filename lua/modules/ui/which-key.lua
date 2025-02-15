--[[
  Description: Displays a popup with possible key bindings
  See: https://github.com/folke/which-key.nvim
]]

local M = {
	"folke/which-key.nvim",
	dependencies = {
		"echasnovski/mini.nvim",
	},
	event = "VeryLazy",
}

function M.config()
	require("mini.icons").setup()
	local wk = require("which-key")
	local icons = require("config.icons")
	wk.setup({
		preset = "helix",
		win = {
			border = "rounded", -- none, single, double, shadow
			title_pos = "center",
			-- margin = { 1, 0, 1, 0 },  -- extra window margin [top, right, bottom, left]
			-- padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
			wo = {
				winblend = 0,
			},
		},
		layout = {
			height = { min = 4, max = 25 }, -- min and max height of the columns
			width = { min = 20, max = 50 }, -- min and max width of the columns
			spacing = 3, -- spacing between columns
			align = "left", -- align columns left, center or right
		},
		icons = {
			breadcrumb = icons.ui.Separator,
		},
	})

	wk.add({
		{ "[", group = "Jump back" },
		{ "]", group = "Jump forward" },
		{ "g", group = "Goto" },
		{ "z", group = "Fold" },
		{ "<c-w>", group = "Window" },
		{ "<leader>b", group = "Buffer" },
		{ "<leader>c", group = "Code" },
		{ "<leader>cd", group = "Diagnostics" },
		{ "<leader>d", group = "Debug" },
		{ "<leader>db", group = "Breakpoint" },
		{ "<leader>f", group = "Find" },
		{ "<leader>g", group = "Git" },
		{ "<leader>gg", group = "Show" },
		{ "<leader>gt", group = "Toggle" },
		{ "<leader>h", group = "Help" },
		{
			"<leader>hm",
			function()
				vim.cmd([[WhichKey]])
			end,
			desc = "Show mapping",
		},
		{
			"<leader>hk",
			function()
				vim.cmd([[Legendary]])
			end,
			desc = "Lookup key...",
		},
		{ "<leader>m", group = "Multicursors" },
		{ "<leader>n", group = "Navigate" },
		{ "<leader>o", group = "Oversee" },
		{ "<leader>r", group = "Replace" },
		{ "<leader>t", group = "Test" },
		{ "<leader>u", group = "UI" },
		{ "<leader>w", group = "Window" },
		{ "<leader>x", group = "Trouble" },
	})
end

return M
