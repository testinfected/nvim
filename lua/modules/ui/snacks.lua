--[[
  Description: A collection of small quality of life plugins
  See: https://github.com/folke/snacks.nvim
]]

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		bigfile = {},
		dim = {},
		explorer = {},
		indent = {},
		input = {},
		notifier = {
			width = {
				min = 30,
			},
			timeout = 3000,
		},
		picker = {
			sources = {
				explorer = {
					-- your explorer picker configuration comes here
					-- or leave it empty to use the default settings
				},
			},
		},
		quickfile = {},
		scroll = {},
		statuscolumn = {
			enabled = false, -- as it doesn't support DAP integration nor test coverage marks
			left = { "mark", "sign" }, -- priority of signs on the left (high to low)
			right = { "fold", "git" }, -- priority of signs on the right (high to low)
			folds = {
				open = true, -- show open fold icons
				git_hl = false, -- use Git Signs hl for fold icons
			},
			git = {
				-- patterns to match Git signs
				patterns = { "GitSign", "MiniDiffSign" },
			},
			refresh = 50, -- refresh at most every 50ms
		},

		words = {},
		zen = {},
		styles = {
			notification = {
				wo = {
					winblend = "0",
				}, -- Wrap notifications
			},
			input = {
				width = 30,
				relative = "cursor",
			},
		},
	},
	keys = {
		{
			"<leader><space>",
			function()
				Snacks.picker.smart()
			end,
			desc = "Smart find files",
		},
		{
			"<leader>,",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Buffers",
		},
		{
			"<leader>/",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep",
		},
		{
			"<leader>:",
			function()
				Snacks.picker.command_history()
			end,
			desc = "Recent commands",
		},
		{
			"<leader>e",
			function()
				Snacks.explorer.open()
			end,
			desc = "File explorer",
		},
		{
			"<leader>\\",
			function()
				Snacks.terminal()
			end,
			desc = "Toggle terminal",
		},
		{
			"<c-_>",
			function()
				Snacks.terminal()
			end,
			desc = "which_key_ignore",
		},
		{
			"]]",
			function()
				Snacks.words.jump(vim.v.count1)
			end,
			desc = "Next reference",
			mode = { "n", "t" },
		},
		{
			"[[",
			function()
				Snacks.words.jump(-vim.v.count1)
			end,
			desc = "Prev reference",
			mode = { "n", "t" },
		},
		-- buffer
		{
			"<leader>bd",
			function()
				Snacks.bufdelete()
			end,
			desc = "Delete",
		},
		{
			"<leader>br",
			function()
				Snacks.rename.rename_file()
			end,
			desc = "Rename",
		},
		-- code
		{
			"<leader>co",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "Outline",
		},
		{
			"<leader>cs",
			function()
				Snacks.picker.lsp_workspace_symbols()
			end,
			desc = "Workspace symbols",
		},
		-- find
		{
			"<leader>fb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Buffers",
		},
		{
			"<leader>ff",
			function()
				Snacks.picker.files()
			end,
			desc = "Files",
		},
		{
			"<leader>fg",
			function()
				Snacks.picker.git_files()
			end,
			desc = "Git files",
		},
		{
			"<leader>fl",
			function()
				Snacks.explorer.reveal()
			end,
			desc = "Locate file in explorer",
		},
		{
			"<leader>fr",
			function()
				Snacks.picker.recent()
			end,
			desc = "Recent files",
		},
		-- git
		{
			"<leader>gb",
			function()
				Snacks.git.blame_line()
			end,
			desc = "Blame line",
		},
		{
			"<leader>gc",
			function()
				Snacks.lazygit()
			end,
			desc = "Lazygit",
		},
		{
			"<leader>gb",
			function()
				Snacks.picker.git_branches()
			end,
			desc = "Branches",
		},
		{
			"<leader>gf",
			function()
				Snacks.picker.git_log_line()
			end,
			desc = "Log file",
		},
		{
			"<leader>gl",
			function()
				Snacks.picker.git_log()
			end,
			desc = "Log",
		},
		{
			"<leader>gL",
			function()
				Snacks.picker.git_log_line()
			end,
			desc = "Log line",
		},
		{
			"<leader>gs",
			function()
				Snacks.picker.git_status()
			end,
			desc = "Status",
		},
		{
			"<leader>gS",
			function()
				Snacks.picker.git_stash()
			end,
			desc = "Stash",
		},
		{
			"<leader>gd",
			function()
				Snacks.picker.git_diff()
			end,
			desc = "Diff",
		},
		{
			"<leader>gh",
			function()
				Snacks.picker.git_log_file()
			end,
			desc = "History",
		},
		-- search
		{
			'<leader>s"',
			function()
				Snacks.picker.registers()
			end,
			desc = "Registers",
		},
		{
			"<leader>s/",
			function()
				Snacks.picker.search_history()
			end,
			desc = "Search history",
		},
		{
			"<leader>sa",
			function()
				Snacks.picker.autocmds()
			end,
			desc = "Autocmds",
		},
		{
			"<leader>sb",
			function()
				Snacks.picker.lines()
			end,
			desc = "Buffer",
		},
		{
			"<leader>sB",
			function()
				Snacks.picker.grep_buffers()
			end,
			desc = "Open Buffers",
		},
		{
			"<leader>sc",
			function()
				Snacks.picker.command_history()
			end,
			desc = "Command history",
		},
		{
			"<leader>sC",
			function()
				Snacks.picker.commands()
			end,
			desc = "Commands",
		},
		{
			"<leader>sd",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "Diagnostics",
		},
		{
			"<leader>sD",
			function()
				Snacks.picker.diagnostics_buffer()
			end,
			desc = "Buffer diagnostics",
		},
		{
			"<leader>sg",
			function()
				Snacks.picker.grep()
			end,
			desc = "Everywhere",
		},
		{
			"<leader>sh",
			function()
				Snacks.picker.help()
			end,
			desc = "Help",
		},
		{
			"<leader>sH",
			function()
				Snacks.picker.highlights()
			end,
			desc = "Highlights",
		},
		{
			"<leader>si",
			function()
				Snacks.picker.icons()
			end,
			desc = "Icons",
		},
		{
			"<leader>sj",
			function()
				Snacks.picker.jumps()
			end,
			desc = "Jumps",
		},
		{
			"<leader>sk",
			function()
				Snacks.picker.keymaps()
			end,
			desc = "Keymaps",
		},
		{
			"<leader>sl",
			function()
				Snacks.picker.loclist()
			end,
			desc = "Location list",
		},
		{
			"<leader>sm",
			function()
				Snacks.picker.marks()
			end,
			desc = "Marks",
		},
		{
			"<leader>sM",
			function()
				Snacks.picker.man()
			end,
			desc = "Man pages",
		},
		{
			"<leader>sp",
			function()
				Snacks.picker.lazy()
			end,
			desc = "Search for plugin",
		},
		{
			"<leader>sq",
			function()
				Snacks.picker.qflist()
			end,
			desc = "Quickfix list",
		},
		{
			"<leader>sR",
			function()
				Snacks.picker.resume()
			end,
			desc = "Resume",
		},
		{
			"<leader>su",
			function()
				Snacks.picker.undo()
			end,
			desc = "Undo history",
		},
		{
			"<leader>sw",
			function()
				Snacks.picker.grep_word()
			end,
			desc = "Visual selection or word",
			mode = { "n", "x" },
		},
		{
			"<leader>oC",
			function()
				Snacks.picker.colorschemes()
			end,
			desc = "Colorschemes",
		},
	},
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				-- Setup some globals for debugging (lazy-loaded)
				_G.dd = function(...)
					Snacks.debug.inspect(...)
				end
				_G.bt = function()
					Snacks.debug.backtrace()
				end
				vim.print = _G.dd -- Override print to use snacks for `:=` command
				-- Create some toggle mappings
				Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>os")
				Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>ow")
				Snacks.toggle.option("relativenumber", { name = "Relative number" }):map("<leader>oL")
				Snacks.toggle.animate():map("<leader>oa")
				Snacks.toggle.diagnostics():map("<leader>od")
				Snacks.toggle.dim():map("<leader>oD")
				Snacks.toggle.indent():map("<leader>oi")
				Snacks.toggle.line_number():map("<leader>ol")
				Snacks.toggle
					.option(
						"conceallevel",
						{ name = "Conceal", off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }
					)
					:map("<leader>oc")
				Snacks.toggle.treesitter():map("<leader>oT")
				Snacks.toggle
					.option("background", { off = "light", on = "dark", name = "Dark background" })
					:map("<leader>ob")
				Snacks.toggle.inlay_hints():map("<leader>oh")
				Snacks.toggle.zen():map("<leader>oz")
			end,
		})
	end,
}
