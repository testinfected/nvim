--[[
  Description: Snazzy bufferline for Neovim
  See: https://github.com/akinsho/bufferline.nvim
]]

local M = {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"catppuccin/nvim",
	},
	event = { "BufReadPre", "BufAdd", "BufNew", "BufReadPost" },
}

function M.config()
	local palette = require("catppuccin.palettes").get_palette()
	local bufferline = require("bufferline")

	bufferline.setup({
		highlights = require("catppuccin.groups.integrations.bufferline").get()({
			background = {
				italic = true,
			},
			buffer_selected = {
				bold = true,
			},
		}),
		options = {
			-- indicator = {
				-- style = "underline",
			-- },
			numbers = "ordinal", -- can be 'none' | 'ordinal' | 'buffer_id' | 'both' | function
			diagnostics = "nvim_lsp",
			offsets = {
				{
					filetype = "lazy",
					text = "Lazy",
					highlight = "Title",
					padding = 1,
				},
				{
					filetype = "NvimTree",
					text = "Project files",
					highlight = "Title",
					text_align = "center",
					separator = true,
				},
				{
					filetype = "OverseerList",
					text = "Tasks",
					highlight = "Title",
					text_align = "center",
					separator = true,
				},
			},
			color_icons = true, -- whether or not to add the filetype icon highlights
			show_buffer_icons = true,
			show_buffer_close_icons = true,
			show_close_icon = true,
			show_tab_indicators = true,
			persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
			separator_style = "padded",
			groups = {
				options = {
					toggle_hidden_on_enter = true, -- when you re-enter a hidden group this options re-opens that group so the buffer is visible
				},
				items = {
					{
						name = "Tests", -- Mandatory
						-- highlight always uses fill bg as label fg color,
						--   which results in text color when theme is set to use transparent_bg.
						--   So we'll use the default highlight then set bg color after setup
						highlight = { sp = palette.green },
						auto_close = true, -- whether or not close this group if it doesn't contain the current buffer
						priority = 2, -- determines where it will appear relative to other groups (Optional)
						icon = "", -- Optional
						matcher = function(buf)
							-- Mandatory
							return buf.name:match("%_test") or buf.name:match("%_spec") or buf.name:match("%Test")
						end,
					},
					{
						name = "Docs",
						highlight = { sp = palette.mauve },
						auto_close = true, -- whether or not close this group if it doesn't contain the current buffer
						matcher = function(buf)
							return buf.name:match("%.md") or buf.name:match("%.txt")
						end,
					},
				},
			},
			hover = {
				enabled = true,
				delay = 200,
				reveal = { "close" },
			},
		},
	})

	-- Fix groups highlights
	local function set_group_label_highlight(name, hl)
		vim.cmd(string.format("hi BufferLine%sLabel guifg=%s", name, hl.fg))
	end

	set_group_label_highlight("Tests", { fg = palette.mantle })
	set_group_label_highlight("Docs", { fg = palette.mantle })

	local map = vim.keymap.set
	map("n", "<leader>1", function() bufferline.go_to(1) end, { desc = "Go to buffer 1" })
	map("n", "<leader>2", function() bufferline.go_to(2) end, { desc = "Go to buffer 2" })
	map("n", "<leader>3", function() bufferline.go_to(3) end, { desc = "Go to buffer 3" })
	map("n", "<leader>4", function() bufferline.go_to(4) end, { desc = "Go to buffer 4" })
	map("n", "<leader>5", function() bufferline.go_to(5) end, { desc = "Go to buffer 5" })
	map("n", "<leader>6", function() bufferline.go_to(6) end, { desc = "Go to buffer 6" })
	map("n", "<leader>7", function() bufferline.go_to(7) end, { desc = "Go to buffer 7" })
	map("n", "<leader>8", function() bufferline.go_to(8) end, { desc = "Go to buffer 8" })
	map("n", "<leader>9", function() bufferline.go_to(9) end, { desc = "Go to buffer 9" })
	map("n", "<leader>$", function() bufferline.go_to(-1) end, { desc = "Go to last buffer" })
end

return M