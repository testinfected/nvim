--[[
  File: go.lua
  Description: Feature-rich Go development plugin
  See: https://github.com/ray-x/go.nvim
]]

local M = {
	"ray-x/go.nvim",
	dependencies = {
		"ray-x/guihua.lua",
		"neovim/nvim-lspconfig",
	},
	ft = { "go", "gomod" },
	build = [[:lua require('go.install').update_all_sync()]], -- if you need to install/update all binaries
}

function M.config()
	-- TODO:
	-- [] configure test coverage
	-- [] use lsp snippets from go.nvim
	-- [] integrate null-ls
	-- [] add buffer key mappings for test, etc.

	require("go").setup({
		icons = false, -- We have already setup dap icons so don't want them overridden here
		lsp_cfg = false, -- Use mason, then apply gopls config after setup
		lsp_keymaps = false,
		dap_debug_keymap = false, -- I have set this up already with all my other nvim-dap setup
		textobjects = false, -- Already have textobjects set up so do not add a mapping for this
		run_in_floaterm = true,
		test_runner = "ginkgo",
		trouble = true,
		lua_snip = true,
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
	})

	-- Use go.nvim gopls config with lsp
	require("go.lsp").setup()

	local null_ls = require("null-ls")
	local sources = {
		null_ls.builtins.diagnostics.revive,
		null_ls.builtins.formatting.golines.with({
			extra_args = {
				"--max-len=120",
				"--base-formatter=gofumpt",
			},
		}),
	}
	-- for go.nvim
	local gotest = require("go.null_ls").gotest()
	local gotest_codeaction = require("go.null_ls").gotest_action()
	local golangci_lint = require("go.null_ls").golangci_lint()
	table.insert(sources, gotest)
	table.insert(sources, golangci_lint)
	table.insert(sources, gotest_codeaction)
	null_ls.setup({ sources = sources, debounce = 1000, default_timeout = 5000 })

	-- alternatively
	--null_ls.register(gotest)

	-- Run gofmt + goimports on save
	-- local format_sync_grp = vim.api.nvim_create_augroup("goimports", {})
	vim.api.nvim_create_autocmd("BufWritePre", {
		pattern = "*.go",
		callback = function()
			require("go.format").goimports()
		end,
		group = format_sync_grp,
	})
end

return M
