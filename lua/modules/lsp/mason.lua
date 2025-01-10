--[[
  Description: Portable package manager to install and manage LSP servers, DAP servers, linters, and formatters.
  See: https://github.com/williamboman/mason.nvim
]]

local M = {
	"williamboman/mason.nvim",
	build = [[:MasonUpdate]],
	dependencies = {
		"neovim/nvim-lspconfig",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
	lazy = "false",
}

local servers = {
	"dagger", -- LSP for CUE
	"bashls", -- LSP for Bash
	-- "clojure_lsp",   -- LSP for Clojure
	"cssls", -- LSP for CSS
	"dockerls", -- LSP for Docker (exl. Docker Compose)
	-- "emmet_ls",      -- LSP for Emmet (Vue, HTML, CSS)
	--'fennel_language_server', -- LSP for Fennel
	"gopls", -- LSP for Go
	-- "gradle_ls",     -- LSP for Gradle
	"html", -- LSP for HTML
	"lua_ls", -- LSP for Lua language
	"marksman", -- LSP for Markdown
	-- "pyright", -- LSP for Python
	-- 'ruby_ls',                -- LSP for Ruby
	"rust_analyzer", -- LSP for Rust
	"sqlls", -- LSP for SQL
	"taplo", -- LSP for TOML
	"lemminx", -- LSP for XML
	-- "ts_ls",         -- LSP for Typescript and Javascript
	-- "yamlls",        -- LSP for YAML
}

function M.config()
	require("mason").setup({
		ui = {
			border = "rounded",
		},
	})

	local mason_lspconfig = require("mason-lspconfig")
	mason_lspconfig.setup({
		ensure_installed = servers,
	})

	--Setup every needed language server in lspconfig
	local capabilities = require("cmp_nvim_lsp").default_capabilities()
	capabilities.textDocument.foldingRange = {
		dynamicRegistration = false,
		lineFoldingOnly = true,
	}

	mason_lspconfig.setup_handlers({
		function(server_name)
			local contains = function(table, value)
				for index = 1, #table do
					if table[index] == value then
						return true
					end
				end
				return false
			end

			-- exclusion list
			local excludes = {
				"rust_analyzer", -- taken car of by rustacean
			}
			if contains(excludes, server_name) then
				require("lspconfig")[server_name] = function()
					return true
				end
			else
				require("lspconfig")[server_name].setup({
					capabilities = capabilities,
				})
			end
		end,
	})

	vim.api.nvim_create_autocmd({ "LspAttach", "CursorHold", "BufEnter", "InsertLeave" }, {
		desc = "Auto show code lenses",
		callback = function(args)
			vim.lsp.codelens.refresh({ bufnr = args.buf })
		end,
	})

	-- I like rounded borders obviously
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end

return M
