--[[
  Description: Configuration of tree-sitter in Neovim
  See: https://github.com/nvim-treesitter/nvim-treesitter
]]

return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = [[:TSUpdate]],
	event = { "BufRead" },
	config = function()
		require("nvim-treesitter").install({
			-- "clojure",
			"comment",
			"cue",
			"go",
			"gomod",
			"gosum",
			"javascript",
			"json",
			"lua",
			"make",
			"markdown",
			"markdown_inline",
			"python",
			"regex",
			-- "ruby",
			"rust",
			"ron",
			-- "typescript",
			"vim",
			"vimdoc",
		})

		-- todo add to respective modules
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "lua", "go", "gomod", "rust", "cue", "python" },
			callback = function()
				vim.treesitter.start()
			end,
		})
	end,
}
