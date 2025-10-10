--[[
  Description: A blazing fast and easy to configure neovim statusline plugin
  See: https://github.com/nvim-lualine/lualine.nvim
]]

return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"catppuccin",
	},
	event = { "VimEnter" },
	config = function()
		local conditions = {
			buffer_not_empty = function()
				return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
			end,
			hide_in_width = function()
				return vim.fn.winwidth(0) > 80
			end,
			in_git_workspace = function()
				local filepath = vim.fn.expand("%:p:h")
				local gitdir = vim.fn.finddir(".git", filepath .. ";")
				return gitdir and #gitdir > 0 and #gitdir < #filepath
			end,
		}

		local icons = require("config.icons")

		local diff = {
			"diff",
			symbols = {
				added = icons.git.LineAdded .. " ",
				modified = icons.git.LineModified .. " ",
				removed = icons.git.LineRemoved .. " ",
			}, -- changes diff symbols
			cond = conditions.hide_in_width,
		}

		-- Adapted from catppuccin lualine integration, see https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/utils/lualine.lua
		local function bubble_theme()
			local C = require("catppuccin.palettes").get_palette()
			local options = require("catppuccin").options

			local transparent_bg = options.transparent_background and "NONE" or C.mantle

			return {
				normal = {
					a = { bg = C.blue, fg = C.mantle, gui = "bold" },
					b = { bg = C.surface1, fg = C.text },
					c = { bg = transparent_bg, fg = C.text },
				},

				insert = {
					a = { bg = C.green, fg = C.base, gui = "bold" },
					b = { bg = C.surface1, fg = C.text },
				},

				terminal = {
					a = { bg = C.teal, fg = C.base, gui = "bold" },
					b = { bg = C.surface1, fg = C.text },
				},

				command = {
					a = { bg = C.peach, fg = C.base, gui = "bold" },
					b = { bg = C.surface1, fg = C.text },
				},

				visual = {
					a = { bg = C.mauve, fg = C.base, gui = "bold" },
					b = { bg = C.surface1, fg = C.text },
				},

				replace = {
					a = { bg = C.red, fg = C.base, gui = "bold" },
					b = { bg = C.surface1, fg = C.text },
				},

				inactive = {
					a = { bg = transparent_bg, fg = C.blue },
					b = { bg = transparent_bg, fg = C.surface1, gui = "bold" },
					c = { bg = transparent_bg, fg = C.overlay0 },
				},
			}
		end
		vim.o.showmode = false -- Don't show mode anymore, lualine takes care of that

		require("lualine").setup({
			options = {
				theme = bubble_theme(),
				component_separators = icons.ui.VerticalDottedLineThick,
				section_separators = { left = icons.ui.RightPill, right = icons.ui.LeftPill },
				disabled_filetypes = {
					"snacks_layout_box",
					"",
					"quickfix",
				},
			},
			sections = {
				lualine_a = {
					{ "mode", separator = { left = icons.ui.LeftPill }, right_padding = 2 },
				},
				lualine_b = {
					{
						"filename",
						symbols = { modified = icons.file.Modified, readonly = icons.file.ReadOnly, unnamed = "" },
						cond = conditions.buffer_not_empty,
					},
					{ "branch", cond = conditions.in_git_workspace },
					diff,
				},
				lualine_c = {
					function()
						return require("screenkey").get_keys()
					end,
				},
				lualine_x = {},
				lualine_y = { "filetype", "lsp_status", "diagnostics", "progress" },
				lualine_z = {
					{ "location", separator = { right = icons.ui.RightPill }, left_padding = 2 },
				},
			},
			inactive_sections = {
				lualine_a = { "filename" },
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = { "location" },
			},
			tabline = {},
			extensions = {
				"lazy",
				"mason",
				"nvim-dap-ui",
				"quickfix",
			},
		})
	end,
}
