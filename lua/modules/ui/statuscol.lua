--[[
  Description: Configurable status column with click handlers
  See: https://github.com/luukvbaal/statuscol.nvim
]]

return {
	"luukvbaal/statuscol.nvim",
	event = "VeryLazy",
	enabled = true,
	config = function()
		local builtin = require("statuscol.builtin")
		require("statuscol").setup({
			-- configuration goes here, for example:
			relculright = true,
			segments = {
				{ sign = { name = { "Dap*" }, maxwidth = 1, colwidth = 1, auto = true }, click = "v:lua.ScSa" },
				{
					sign = { namespace = { "diagnostic/signs" }, auto = true },
					click = "v:lua.ScSa",
				},
				{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
				{ text = { builtin.foldfunc }, click = "v:lua.ScFa" },
				{
					sign = { namespace = { "gitsigns" }, maxwidth = 1, colwidth = 1, auto = false, foldclosed = true },
					click = "v:lua.ScSa",
				},
				{ sign = { name = { "coverage.*" }, maxwidth = 1, colwidth = 1, auto = true } },
				{ sign = { name = { "neotest_*" }, maxwidth = 1, colwidth = 2, auto = true } },
			},
		})
	end,
}
