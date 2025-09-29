return {
	"dnlhc/glance.nvim",
	cmd = "Glance",
	event = "LspAttach",
	config = function()
		require("glance").setup({
			border = {
				enable = true,
			},
		})
		vim.keymap.set("n", "grd", "<CMD>Glance definitions<CR>", { desc = "Glance definition" })
		vim.keymap.set("n", "grr", "<CMD>Glance references<CR>", { desc = "Glance references" })
		vim.keymap.set("n", "grt", "<CMD>Glance type_definitions<CR>", { desc = "Glance type definition" })
		vim.keymap.set("n", "gri", "<CMD>Glance implementations<CR>", { desc = "Glance implementations" })
	end,
}
