--[[
  Description: Catppuccin theme for (Neo)vim
  See: https://github.com/catppuccin/nvim
]]

return {
	"catppuccin/nvim",
	name = "catppuccin",
	-- Load immediately to make it available for lazy
	lazy = false,
	-- Load before anything else since this is our main theme
	priority = 1000,
	config = function()
		local catppuccin = require("catppuccin")
		local colors = require("catppuccin.utils.colors")
		local transparent_background = true
		local clear = {}

		catppuccin.setup({
			--flavor = 'macchiato',
			flavor = "mocha",
			transparent_background = transparent_background,
			term_colors = true,
			dim_inactive = {
				enabled = false, -- dims the background color of inactive window
				shade = "dark",
				percentage = 0.15, -- percentage of the shade to apply to the inactive window
			},
			styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
				comments = { "italic" }, -- Change the style of comments
				conditionals = { "italic" },
				loops = {},
				functions = {},
				keywords = {},
				startings = {},
				variables = {},
				numbers = {},
				booleans = {},
				properties = {},
				types = {},
				operators = {},
			},
			color_overrides = {},
			custom_higlights = function(palette)
				return {
					-- For base connigs
					NormalFloat = { fg = palette.text, bg = transparent_background and palette.none or palette.mantle },
					FloatBorder = {
						fg = transparent_background and palette.blue or palette.mantle,
						bg = transparent_background and palette.none or palette.mantle,
					},
					CursorLineNr = { fg = palette.green },

					-- For Bufferline (with Barbar)
					BufferTabpageFill = { bg = transparent_background and palette.none or palette.base },
					BufferInactive = { bg = palette.base },
					BufferInactiveBtn = { bg = palette.base },
					BufferInactiveIcon = { bg = palette.base },
					BufferInactiveSign = { bg = palette.base },
					BufferInactiveIndex = { bg = palette.base },
					BufferInactiveNumber = { bg = palette.base },
					BufferInactivePin = { bg = palette.base },

					-- For native lsp configs
					DiagnosticVirtualTextError = { bg = palette.none },
					DiagnosticVirtualTextWarn = { bg = palette.none },
					DiagnosticVirtualTextInfo = { bg = palette.none },
					DiagnosticVirtualTextHint = { bg = palette.none },
					LspInfoBorder = { link = "FloatBorder" },

					-- For mason.nvim
					MasonNormal = { link = "NormalFloat" },

					-- For treesitter
					["@keyword.return"] = { fg = palette.pink, style = clear },
					["@error.c"] = { fg = palette.none, style = clear },
					["@error.cpp"] = { fg = palette.none, style = clear },

					-- For time-machine.nvim
					TimeMachineCurrent = {
						bg = colors.darken(palette.blue, 0.18, palette.base),
					},
					TimeMachineTimeline = { fg = palette.blue, style = { "bold" } },
					TimeMachineTimelineAlt = { fg = palette.overlay2 },
					TimeMachineKeymap = { fg = palette.teal, style = { "italic" } },
					TimeMachineInfo = { fg = palette.subtext0, style = { "italic" } },
					TimeMachineSeq = { fg = palette.peach, style = { "bold" } },
					TimeMachineTag = { fg = palette.yellow, style = { "bold" } },
				}
			end,

			default_integrations = true,
			auto_integrations = true,
			integrations = {
				blink_cmp = {
					styled = "bordered",
				},
				dap = {
					enabled = true,
					enable_ui = true, -- enable nvim-dap-ui
				},
				gitsigns = {
					enabled = true,
					-- align with the transparent_background option by default
					transparent = true,
				},
				illuminate = {
					enabled = true,
					lsp = true,
				},
				lsp_styles = {
					enabled = true,
					virtual_text = {
						errors = { "italic" },
						hints = { "italic" },
						warnings = { "italic" },
						information = { "italic" },
					},
					underlines = {
						errors = { "underline" },
						hints = { "underline" },
						warnings = { "underline" },
						information = { "underline" },
					},
					inlay_hints = {
						background = true,
					},
				},
				mini = {
					enabled = true,
				},
				neotest = true,
			},
		})

		vim.cmd([[colorscheme catppuccin]])
	end,
}
