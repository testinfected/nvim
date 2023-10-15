--[[
  File: colorizer.lua
  Description: High-performance color highlighter
  See: https://github.com/NvChad/nvim-colorizer.lua
]]

local M = {
  'NvChad/nvim-colorizer.lua',
  keys = {
    { '<leader>cc', [[<Cmd>ColorizerToggle<CR>]], desc = "Toggle color highlighting" }
  }
}

function M.config()
  require('colorizer').setup {
    RRGGBBAA = true, -- #RRGGBBAA hex codes
    AARRGGBB = true, -- 0xAARRGGBB hex codes
    css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
  }
end

return M