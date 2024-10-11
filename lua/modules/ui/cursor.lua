--[[
  Description: Flash cursor when it jumps some distance or moves between windows
  See: https://github.com/rainbowhxch/beacon.nvim
]]

local M = {
    'danilamihailov/beacon.nvim',
    event = 'VeryLazy',
}

function M.config()
    require('beacon').setup({
    })
end

return M
