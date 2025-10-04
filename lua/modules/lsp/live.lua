return {
	"onsails/diaglist.nvim",
	event = "LspAttach",
	config = function()
		local diag = require("diaglist")
		diag.init({
			-- optional settings
			-- below are defaults
			debug = false,

			-- increase for noisy servers
			debounce_ms = 150,
		})
		vim.keymap.set("n", "<leader>xw", diag.open_all_diagnostics, { desc = "Workspace" })
		vim.keymap.set("n", "<leader>x0", diag.open_buffer_diagnostics, { desc = "Current buffer" })
	end,
}
