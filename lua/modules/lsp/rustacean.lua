return {
	"mrcjkb/rustaceanvim",
	version = "^6", -- Recommended
	lazy = false, -- This plugin is already lazy
	config = function()
		vim.g.rustaceanvim = {
			server = {
				on_attach = function(_, bufnr)
					vim.keymap.set("n", "gra", function()
						vim.cmd.RustLsp("codeAction")
					end, { desc = "Code action", buffer = bufnr })
					vim.keymap.set("n", "<leader>dr", function()
						vim.cmd.RustLsp("debuggables")
					end, { desc = "Rust debuggables", buffer = bufnr })
					vim.keymap.set("n", "K", function()
						vim.cmd.RustLsp({ "hover", "actions" })
					end, { silent = true, buffer = bufnr })
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
			},
			tools = {
				float_win_config = {
					border = "rounded",
				},
			},
		}
	end,
}
