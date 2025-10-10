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

		local progress = vim.defaulttable()
		vim.api.nvim_create_autocmd("LspProgress", {
			callback = function(ev)
				local client = vim.lsp.get_client_by_id(ev.data.client_id)
				local value = ev.data.params.value
				if not client or type(value) ~= "table" then
					return
				end
				local p = progress[client.id]

				for i = 1, #p + 1 do
					if i == #p + 1 or p[i].token == ev.data.params.token then
						-- only keep the first sentence
						local message = value.message and string.gsub(value.message, "%.%s.*$", "")
						p[i] = {
							token = ev.data.params.token,
							msg = ("[%3d%%] %s%s"):format(
								value.kind == "end" and 100 or value.percentage or 100,
								value.title or "",
								message and (" **%s**"):format(message) or ""
							),
							done = value.kind == "end",
						}
						break
					end
				end

				local msg = {}
				progress[client.id] = vim.tbl_filter(function(v)
					return table.insert(msg, v.msg) or not v.done
				end, p)

				local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
				vim.notify(table.concat(msg, "\n"), "info", {
					id = "lsp_progress",
					title = client.name,
					opts = function(notif)
						notif.icon = #progress[client.id] == 0 and " "
							or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
					end,
				})
			end,
		})
	end,
}
