--[[
  Description: Browse the file system and other tree like structures
  See: https://github.com/nvim-tree/rvim-tree.lua
]]

local M = {
	"nvim-tree/nvim-tree.lua",
	keys = {
		{ "<leader>e", [[<Cmd>NvimTreeToggle<CR>]], desc = "File explorer" },
	},
}

function M.config()
	local icons = require("config.icons")

	require("nvim-tree").setup({ -- BEGIN_DEFAULT_OPTS
		view = {
			width = 50,
		},
		renderer = {
			icons = {
				glyphs = {
					git = {
						unstaged = icons.git.FileUnstaged,
						untracked = icons.git.FileUntracked,
					},
				},
			},
		},
		diagnostics = {
			icons = {
				hint = icons.diagnostics.Hint,
				info = icons.diagnostics.Info,
				warning = icons.diagnostics.Warning,
				error = icons.diagnostics.Error,
			},
		},
	})
end

return M
