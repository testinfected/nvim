return {
	"romgrk/barbar.nvim",
	dependencies = {
		"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
		"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
	},
	event = { "VimEnter" },
	config = function()
		vim.g.barbar_auto_setup = false

		local icons = require("config.icons")
		require("barbar").setup({
			auto_hide = 1,
			icons = {
				-- Configure the base icons on the bufferline.
				-- Valid options to display the buffer index and -number are `true`, 'superscript' and 'subscript'
				buffer_index = true,
				button = icons.ui.Close,
				-- Enables / disables diagnostic symbols
				diagnostics = {
					[vim.diagnostic.severity.ERROR] = { enabled = true, icon = icons.diagnostics.Error },
				},
				filetype = {
					-- Sets the icon's highlight group.
					-- If false, will use nvim-web-devicons colors
					custom_colors = false,
					-- Requires `nvim-web-devicons` if `true`
					enabled = true,
				},
				separator = { left = icons.ui.LeftBorderLine, right = "" },

				-- If true, add an additional separator at the end of the buffer list
				separator_at_end = true,

				-- Configure the icons on the bufferline when modified or pinned.
				-- Supports all the base icon options.
				modified = { button = icons.file.Modified },
				pinned = { button = icons.file.Pinned, filename = true },
			},
			sidebar_filetypes = {
				-- Use the default values: {event = 'BufWinLeave', text = '', align = 'left'}
				snacks_layout_box = true,
			},
		})

		-- Wipeout buffer
		--                 :BufferWipeout
		-- Close commands
		--                 :BufferCloseAllButCurrent
		--                 :BufferCloseAllButPinned
		--                 :BufferCloseAllButCurrentOrPinned
		--                 :BufferCloseBuffersLeft
		--                 :BufferCloseBuffersRight
		-- Sort automatically by...
		-- :BufferOrderByBufferNumber
		-- :BufferOrderByName
		-- :BufferOrderByDirectory
		-- :BufferOrderByLanguage
		-- :BufferOrderByWindowNumber

		-- Other:
		-- :BarbarEnable - enables barbar (enabled by default)
		-- :BarbarDisable - very bad command, should never be used
	end,
}
