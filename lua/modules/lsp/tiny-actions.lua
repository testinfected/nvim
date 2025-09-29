return {
	"rachartier/tiny-code-action.nvim",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{
			"folke/snacks.nvim",
		},
	},
	event = "LspAttach",
	config = function()
		local actions = require("tiny-code-action")
		actions.setup({
			backend = "difftastic", -- choice of vim, delta, difftastic and diffsofancy
			picker = "snacks",
			signs = {
				quickfix = { "", { link = "DiagnosticWarning" } },
				others = { "", { link = "DiagnosticWarning" } },
				refactor = { "", { link = "DiagnosticInfo" } },
				["refactor.move"] = { "󰪹", { link = "DiagnosticInfo" } },
				["refactor.extract"] = { "", { link = "DiagnosticError" } },
				["source.organizeImports"] = { "", { link = "DiagnosticWarning" } },
				["source.fixAll"] = { "󰃢", { link = "DiagnosticError" } },
				["source"] = { "", { link = "DiagnosticError" } },
				["rename"] = { "󰑕", { link = "DiagnosticWarning" } },
				["codeAction"] = { "", { link = "DiagnosticWarning" } },
			},
		})
		-- Override default code action
		vim.keymap.set({ "n", "x" }, "gra", function()
			require("tiny-code-action").code_action()
		end, { noremap = true, silent = true, desc = "Code actions" })
		vim.keymap.set("n", "grl", function()
			vim.lsp.codelens.run()
		end, { desc = "Code lens", buffer = bufnr })
		vim.keymap.set("n", "<leader>cf", function()
			vim.lsp.buf.format()
		end, { desc = "Format", buffer = bufnr })
	end,
}
