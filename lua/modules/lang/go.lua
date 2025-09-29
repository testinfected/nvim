--[[
  Description: Feature-rich Go development plugin
  See: https://github.com/ray-x/go.nvim
]]

return {
	"ray-x/go.nvim",
	dependencies = {
		"mason-org/mason.nvim",
		"mason-org/mason-lspconfig.nvim",
	},
	ft = { "go", "gomod" },
	build = ':lua require("go.install").update_all_sync()',
	config = function()
		require("go").setup({
			icons = false, -- We have already setup dap icons so don't want them overridden here
			lsp_codelens = true,
			lsp_document_formatting = true,
			lsp_keymaps = false,
			dap_debug_keymap = false, -- I have set this up already with all my other nvim-dap setup
			textobjects = false, -- Already have textobjects set up so do not add a mapping for this
			test_runner = "ginkgo",
			-- trouble = true,
			luasnip = false,
			lsp_inlay_hints = {
				enable = true,
				-- whether to show variable name before type hints with the inlay hints or not
				-- default: false
				show_variable_name = true,
				-- prefix for parameter hints
				parameter_hints_prefix = "󰊕 ",
				show_parameter_hints = true,
				-- prefix for all the other hints (type, chaining)
				other_hints_prefix = "=> ",
				-- whether to align to the lenght of the longest line in the file
				max_len_align = false,
				-- padding from the left if max_len_align is true
				max_len_align_padding = 1,
				-- whether to align to the extreme right or not
				right_align = false,
				-- padding from the right if right_align is true
				right_align_padding = 6,
				-- The color of the hints
				highlight = "Comment",
			},

			run_in_floaterm = true,
			floaterm = { -- position
				posititon = "auto", -- one of {`top`, `bottom`, `left`, `right`, `center`, `auto`}
				width = 0.4,
				height = 0.9, -- height of float window if not auto
				-- title_colors = {'#D8DEE9', '#5E81AC', '#88C0D0', '#EBCB8B', '#A3BE8C', '#B48EAD'}
			},
		})

		-- Use go.nvim gopls config with lsp
		require("go.lsp").setup()

		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "go" },
			desc = "Go Test key bindings",
			callback = function()
				vim.keymap.set("n", "<leader>tt", "[[<cmd>GoTestFile<cr>]]", { desc = "Run for current file" })
				vim.keymap.set("n", "<leader>tc", "[[<cmd>GoTermClose<cr>]]", { desc = "Close output" })
			end,
		})
	end,
}
