local M = {
	"mrcjkb/rustaceanvim",
	version = "^5", -- Recommended
	lazy = false, -- This plugin is already lazy
}

function M.config()
	-- use codelldb adapter installed by mason
	local mason_registry = require("mason-registry")
	local codelldb = mason_registry.get_package("codelldb")
	local extension_path = codelldb:get_install_path() .. "/extension/"
	local codelldb_path = extension_path .. "adapter/codelldb"
	local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
	local cfg = require("rustaceanvim.config")

	vim.g.rustaceanvim = {
		server = {
			on_attach = function(_, bufnr)
				vim.keymap.set("n", "<leader>ca", function()
					vim.cmd.RustLsp("codeAction")
				end, { desc = "Code Action", buffer = bufnr })
				vim.keymap.set("n", "<leader>dr", function()
					vim.cmd.RustLsp("debuggables")
				end, { desc = "Rust Debuggables", buffer = bufnr })
				vim.keymap.set("n", "K", function()
					vim.cmd.RustLsp({ "hover", "actions" })
				end, { silent = true, buffer = bufnr })
				vim.keymap.set("n", "gd", function()
					require("navigator.definition").definition()
				end, { desc = "Definition", buffer = bufnr })
				vim.keymap.set("n", "gr", function()
					require("navigator.reference").async_ref()
				end, { desc = "Reference", buffer = bufnr })
				vim.keymap.set("n", "<leader>cf", function()
					vim.lsp.buf.format()
				end, { desc = "Format", buffer = bufnr })
				vim.keymap.set("v", "<leader>cf", function()
					require("navigator.formatting").range_format()
				end, { desc = "Format Selected", buffer = bufnr })
				vim.keymap.set("n", "<leader>cr", function()
					require("navigator.rename").rename()
				end, { desc = "Rename", buffer = bufnr })
			end,
			default_settings = {
				-- rust-analyzer language server configuration
				["rust-analyzer"] = {
					cargo = {
						allFeatures = true,
						loadOutDirsFromCheck = true,
						buildScripts = {
							enable = true,
						},
					},
					-- Add clippy lints for Rust if using rust-analyzer
					checkOnSave = true,
					-- Enable diagnostics if using rust-analyzer
					diagnostics = {
						enable = true,
					},
					procMacro = {
						enable = true,
						ignored = {
							["async-trait"] = { "async_trait" },
							["napi-derive"] = { "napi" },
							["async-recursion"] = { "async_recursion" },
						},
					},
				},
			},
			-- pick up the rust-analyzer from mason if installed
			cmd = function()
				if mason_registry.is_installed("rust-analyzer") then
					-- This may need to be tweaked depending on the operating system.
					local ra = mason_registry.get_package("rust-analyzer")
					local ra_filename = ra:get_receipt():get().links.bin["rust-analyzer"]
					return { ("%s/%s"):format(ra:get_install_path(), ra_filename or "rust-analyzer") }
				else
					-- otherwhise the one from the rust toolchaine installation
					return { "rust-analyzer" }
				end
			end,
		},
		dap = {
			adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
		},
		tools = {
			float_win_config = {
				border = "rounded",
			},
		},
	}
end

return M
