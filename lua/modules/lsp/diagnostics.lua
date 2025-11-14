return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = "VeryLazy",
	priority = 1000,
	config = function()
		require("tiny-inline-diagnostic").setup({
			-- Style preset for diagnostic messages
			-- Available options: "modern", "classic", "minimal", "powerline", "ghost", "simple", "nonerdfont", "amongus"
			preset = "modern",
		})
		vim.api.nvim_create_autocmd({ "LspAttach" }, {
			desc = "Disable default virtual text",
			callback = function(args)
				vim.diagnostic.config({ virtual_text = false })
			end,
		})

		local icons = require("config/icons")
		vim.diagnostic.config({
			virtual_text = true,
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = icons.diagnostics.Error, -- Example: Using a Nerd Font icon for errors
					[vim.diagnostic.severity.WARN] = icons.diagnostics.Warning, -- Example: Using a Nerd Font icon for warnings
					[vim.diagnostic.severity.INFO] = icons.diagnostics.Info, -- Example: Using a Nerd Font icon for info
					[vim.diagnostic.severity.HINT] = icons.diagnostics.Hint, -- Example: Using a Nerd Font icon for hints
				},
				-- Optional: define highlight groups for the sign column
				numhl = {
					[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
					[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
					[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
					[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
				},
			},
			underline = true,
			update_in_insert = false,
			severity_sort = true,
		})
	end,
}
