--[[
  Description: Experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu
  See: https://github.com/folke/noice.nvim
]]

return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("noice").setup({
			cmdline = {
				enabled = true, -- enable Noice cmdline UI
				view = "cmdline", -- view for rendering the cmdline. Change to `cmdline_popup` to get a cmdline popup at the center
			},
			messages = {
				-- NOTE: If you enable messages, then the cmdline is enabled automatically.
				enabled = true, -- enable Noice messages UI
				view = "mini",
			},
			popupmenu = {
				enabled = true, -- enable Noice command line popupmenu UI
				---@type 'nui'|'cmp'
				backend = "nui", -- use cmp as a backend to show cmdline completions
				-- backend = 'cmp',                           -- use cmp as a backend to show cmdline completions
				-- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
				kind_icons = require("config.icons").kind, -- set to `false` to disable icons
			},
			notify = {
				-- Use noice as `vim.notify`?
				enabled = false,
			},
			lsp = {
				progress = {
					enabled = false,
				},
				hover = {
					enabled = false,
				},
				signature = {
					enabled = false,
				},
				message = {
					-- Messages shown by lsp servers
					enabled = true,
				},
				override = {
					-- override the default lsp markdown formatter with Noice
					["vim.lsp.util.convert_input_to_markdown_lines"] = false,
					-- override the lsp markdown formatter with Noice
					["vim.lsp.util.stylize_markdown"] = false,
				},
			},
			presets = {
				-- you can enable a preset by setting it to true, or a table that will override the preset config
				-- you can also add custom presets that you can enable/disable with enabled=true
				bottom_search = true, -- turn on to use a classic bottom cmdline for search
				command_palette = false, -- turn on to position the cmdline and popupmenu together
				long_message_to_split = true, -- turn on to send long messages to a split
				inc_rename = false, -- turn on to enable an input dialog for inc-rename.nvim
				lsp_doc_border = "rounded", -- add a border to hover docs and signature help
			},
			views = {
				mini = {
					position = {
						row = -2,
						col = "100%",
					},
				},
			},
		})
	end,
}
