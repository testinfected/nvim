--[[
  Description: Portable package manager to install and manage LSP servers, DAP servers, linters, and formatters.
  See: https://github.com/williamboman/mason.nvim
]]

return {
	"mason-org/mason-lspconfig.nvim",
	build = [[:MasonUpdate]],
	dependencies = {
		{ "mason-org/mason.nvim", opts = {}, lazy = false },
		"neovim/nvim-lspconfig",
	},
	lazy = false,
	config = function()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"dagger", -- LSP for CUE
				"bashls", -- LSP for Bash
				"cssls", -- LSP for CSS
				"dockerls", -- LSP for Docker (exl. Docker Compose)
				"gopls",
				-- "harper_ls", -- Grammar checker
				"html", -- LSP for HTML
				"lua_ls", -- LSP for Lua language
				"marksman", -- LSP for Markdown
				"pyright", -- LSP for Python
				"sqlls", -- LSP for SQL
				"taplo", -- LSP for TOML
				"lemminx", -- LSP for XML
				"yamlls", -- LSP for YAML
			},
			automatic_enable = {
				exclude = {
					"rust_analyzer",
				},
			},
		})

		vim.api.nvim_create_autocmd({ "LspAttach", "CursorHold", "BufEnter", "InsertLeave" }, {
			desc = "Auto show code lenses",
			callback = function(args)
				vim.lsp.codelens.refresh({ bufnr = args.buf })
			end,
		})
	end,
}
