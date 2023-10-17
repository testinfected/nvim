--[[
  Description: Smooth scrolling 
  See: hhttps://github.com/karb94/neoscroll.nvim
]]

local M = {
    'karb94/neoscroll.nvim',
    event = 'BufReadPost'
}

function M.config()
    require('neoscroll').setup {
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
        hide_cursor = true,      -- Hide cursor while scrolling
        stop_eof = true,         -- Stop at <EOF> when scrolling downwards
        respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = 'quadratic',   -- Easing function, nil for default
        pre_hook = nil,          -- Function to run before the scrolling animation starts
        post_hook = nil,         -- Function to run after the scrolling animation ends
        performance_mode = false, -- Disable "Performance Mode" on all buffers.
    }
end

return M
