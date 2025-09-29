return {
	"smjonas/inc-rename.nvim",
	event = "LspAttach",
	config = function()
		require("inc_rename").setup({
			input_buffer_type = "snacks",
		})
		vim.keymap.set("n", "grn", function()
			return ":IncRename " .. vim.fn.expand("<cword>")
		end, { expr = true, desc = "Rename..." })
	end,
}
