--[[
  Description: Easily manage multiple terminal window
  See: https://github.com/akinsho/toggleterm.nvim
]]


local M = {
    'akinsho/toggleterm.nvim',
    event = 'VeryLazy',
}

function M.config()
    local toggleterm = require('toggleterm')
    toggleterm.setup {
        open_mapping = [[<leader>\]],
        insert_mappings = false,
        start_in_insert = true,
        direction = 'float',
        shade_terminals = true,
        float_opts = {
            border = 'curved'
        },
        on_open = function()
            -- Prevent infinite calls from freezing neovim.
            -- Only set these options specific to this terminal buffer.
            vim.api.nvim_set_option_value("foldmethod", "manual", { scope = "local" })
            vim.api.nvim_set_option_value("foldexpr", "0", { scope = "local" })
        end,
    }

    -- Keymaps
    local Terminal = require('toggleterm.terminal').Terminal
    local lazygit = Terminal:new { cmd = 'lazygit', hidden = true }
    vim.keymap.set('n', '<leader>gc', function() lazygit:toggle() end, { desc = "Commit" })
end

return M
