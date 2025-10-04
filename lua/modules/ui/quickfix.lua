--[[
  Description: Prettier quickfix/location list windows
  See: https://github.com/yorickpeterse/nvim-pqf
]]

-- return {
-- 	"yorickpeterse/nvim-pqf",
-- 	event = "VeryLazy",
-- 	config = function()
-- 		require("pqf").setup()
-- 	end,
-- }

return {
	"stevearc/quicker.nvim",
	ft = "qf",
	---@module "quicker"
	---@type quicker.SetupOptions
	opts = {},
	keys = {
		{
			"<leader>q",
			function()
				require("quicker").toggle()
			end,
			desc = "Toggle quickfix",
		},
		{
			"<leader>l",
			function()
				require("quicker").toggle({ loclist = true })
			end,
			desc = "Toggle loclist",
		},
	},
	config = function()
		require("quicker").setup({
			follow = {
				-- When quickfix window is open, scroll to closest item to the cursor
				enabled = true,
			},
			keys = {
				{
					">",
					function()
						require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
					end,
					desc = "Expand quickfix context",
				},
				{
					"<",
					function()
						require("quicker").collapse()
					end,
					desc = "Collapse quickfix context",
				},
			},
		})
	end,
}
