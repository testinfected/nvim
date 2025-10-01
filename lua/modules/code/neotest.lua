--[[
  Description: framework for interacting with tests
  See: https://github.com/nvim-neotest/neotest
]]

return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-python",
		"fredrikaverpil/neotest-golang",
		"rouge8/neotest-rust",
	},
	event = "LspAttach",
	config = function()
		-- get neotest namespace (api call creates or returns namespace)
		local neotest_ns = vim.api.nvim_create_namespace("neotest")
		vim.diagnostic.config({
			virtual_text = {
				format = function(diagnostic)
					local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
					return message
				end,
			},
		}, neotest_ns)

		local neotest = require("neotest")
		neotest.setup({
			adapters = {
				require("neotest-python"),
				require("neotest-golang")({ dap_go_enabled = true }),
				require("neotest-rust"),
			},
		})

		-- Keymaps
		local map, prefix = vim.keymap.set, "<leader>t"
		map("n", prefix .. "r", function()
			neotest.run.run()
		end, { desc = "Run nearest" })
		map("n", prefix .. "d", function()
			neotest.run.run({ suite = false, strategy = "dap" })
		end, { desc = "Debug nearest" })
		map("n", prefix .. "t", function()
			neotest.run.run(vim.fn.expand("%"))
		end, { desc = "Run File" })
		map("n", prefix .. "a", function()
			neotest.run.run(vim.loop.cwd())
		end, { desc = "Run all tiles" })
		map("n", prefix .. "s", function()
			neotest.summary.toggle()
		end, { desc = "Toggle summary" })
		map("n", prefix .. "o", function()
			neotest.output.open({ enter = true, auto_close = true })
		end, { desc = "Show output" })
		map("n", prefix .. "O", function()
			neotest.output_panel.toggle()
		end, { desc = "Toggle output panel" })
		map("n", prefix .. "S", function()
			neotest.run.stop()
		end, { desc = "Stop" })
	end,
}
