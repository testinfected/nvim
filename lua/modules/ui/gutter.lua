--[[
  Description: Configurable status column with click handlers
  See: https://github.com/luukvbaal/statuscol.nvim
]]

local M = {
  'luukvbaal/statuscol.nvim',
  event = 'VeryLazy'
}

function M.config()
  local builtin = require('statuscol.builtin')
  require("statuscol").setup {
    -- configuration goes here, for example:
    relculright = true,
    segments = {
      { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
      {
        sign = { name = { "Diagnostic" }, maxwidth = 2, colwidth = 1, auto = true },
        click = "v:lua.ScSa"
      },
      { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
      {
        sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = false, wrap = true },
        click = "v:lua.ScSa"
      },
    }
  }
end

return M