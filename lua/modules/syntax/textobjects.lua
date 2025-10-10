return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	branch = "main",
	dependencies = {
		{ "nvim-treesitter/nvim-treesitter" },
	},
	event = "VeryLazy",
	config = function()
		require("nvim-treesitter-textobjects").setup({
			select = {
				lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
				-- todo rewrite using vim.keymap.set (see online docs)
				-- keymaps = {
				--     -- You can use the capture groups defined in textobjects.scm
				--     -- see https://github.com/nvim-treesitter/nvim-treesitter-textobjects#built-in-textobjects
				--     ["aa"] = "@parameter.outer",
				--     ["ia"] = "@parameter.inner",
				--     ["af"] = "@function.outer",
				--     ["if"] = "@function.inner",
				--     ["ac"] = "@class.outer",
				--     ["ic"] = "@class.inner",
				--     ["aC"] = "@conditional.outer",
				--     ["iC"] = "@conditional.inner",
				--     ["ak"] = "@block.outer",
				--     ["ik"] = "@block.inner",
				--     ["al"] = "@loop.outer",
				--     ["il"] = "@loop.inner",
				--     ["is"] = "@statement.inner",
				--     ["as"] = "@statement.outer",
				--     ["ad"] = "@comment.outer",
				--     ["am"] = "@call.outer",
				--     ["im"] = "@call.inner",
				-- },
				-- You can choose the select mode (default is charwise 'v')
				--
				-- Can also be a function which gets passed a table with the keys
				-- * query_string: eg '@function.inner'
				-- * method: eg 'v' or 'o'
				-- and should return the mode ('v', 'V', or '<c-v>') or a table
				-- mapping query_strings to modes.
				selection_modes = {
					["@parameter.outer"] = "v", -- charwise
					["@function.outer"] = "V", -- linewise
					["@class.outer"] = "<c-v>", -- blockwise
				},
			},
			move = {
				set_jumps = true, -- whether to set jumps in the jumplist
				-- todo rewrite using vim.keymap.set (see online docs)
				-- goto_next_start = {
				--     ["]m"] = "@function.outer",
				--     ["]]"] = "@class.outer",
				-- },
				-- goto_next_end = {
				--     ["]M"] = "@function.outer",
				--     ["]["] = "@class.outer",
				-- },
				-- goto_previous_start = {
				--     ["[m"] = "@function.outer",
				--     ["[["] = "@class.outer",
				-- },
				-- goto_previous_end = {
				--     ["[M"] = "@function.outer",
				--     ["[]"] = "@class.outer",
				-- },
			},
		})
	end,
}
