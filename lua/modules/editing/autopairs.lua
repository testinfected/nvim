--[[
  Description: Autopairs with support for multiple characters.
  See: https://github.com/windwp/nvim-autopairs
]]

return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = function()
		require("nvim-autopairs").setup({
			-- Use treesitter
			check_ts = true,
		})
	end,
}
