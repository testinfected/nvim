--[[
  File: autopairs.lua
  Description: Autopairs with support for multiple characters.
  See: https://github.com/windwp/nvim-autopairs
]]

local M = {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/nvim-cmp'
  }
}

function M.config()
  require('nvim-autopairs').setup {
    -- Use treesitter
    check_ts = true,
  }

  -- If you want insert `(` after select function or method item
  require('cmp').event:on('confirm_done', require('nvim-autopairs.completion.cmp').on_confirm_done())
end

return M

