return {
	"smjonas/inc-rename.nvim",
	event = "LspAttach",
	config = function()
		require("inc_rename").setup({
			input_buffer_type = "snacks",
		})
	end,
}
