--[[
  Description: Flash cursor when it jumps some distance or moves between windows
  See: https://github.com/rainbowhxch/beacon.nvim
]]

local M = {
	'rainbowhxch/beacon.nvim',
	event = 'VeryLazy',
}

function M.config()
	require('beacon').setup({
		enable = true,
		size = 40,
		fade = true,
		minimal_jump = 10,
		show_jumps = true,
		focus_gained = false,
		shrink = true,
		timeout = 500,
		ignore_buffers = {},
		ignore_filetypes = {},
	})
end

return M
