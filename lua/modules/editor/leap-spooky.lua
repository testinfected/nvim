--[[
Description: Allows for remote operations on Vim's native text objects
See: https://github.com/ggandor/leap-spooky.nvim
]]

local M = {
    'ggandor/leap-spooky.nvim',
    requires = {
         'ggandor/leap.nvim'
    },
    event = 'BufEnter'
}

function M.config()
    -- We just use defaults
    require('leap-spooky').setup {
        -- Additional text objects, to be merged with the default ones.
        -- E.g.: {'iq', 'aq'}
        extra_text_objects = nil,
        -- Mappings will be generated corresponding to all native text objects,
        -- like: (ir|ar|iR|aR|im|am|iM|aM){obj}.
        -- Special line objects will also be added, by repeating the affixes.
        -- E.g. `yrr<leap>` and `ymm<leap>` will yank a line in the current window.
        affixes = {
            -- The cursor moves to the targeted object, and stays there.
            magnetic = { window = 'm', cross_window = 'M' },
            -- The operation is executed seemingly remotely (the cursor boomerangs
            -- back afterwards).
            remote = { window = 'r', cross_window = 'R' },
        },
        -- Defines text objects like `riw`, `raw`, etc., instead of
        -- targets.vim-style `irw`, `arw`. (Note: prefix is forced if a custom
        -- text object does not start with "kak" or "i".)
        prefix = false,
        -- The yanked text will automatically be pasted at the cursor position
        -- if the unnamed register is in use.
        paste_on_remote_yank = false,
    }
end

return M
