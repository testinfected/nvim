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
	end,
}
