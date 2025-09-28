--[[
  Description: Smart, seamless, directional navigation and resizing between terminal multiplexer panes and nvim splits
  See: https://github.com/mrjones2014/smart-splits.nvim
]]

return {
    "mrjones2014/smart-splits.nvim",
    lazy = false,
    config = function()
        local splits = require("smart-splits")
        splits.setup()

        local map = vim.keymap.set
        -- these keymaps will also accept a range,
        -- for example `10<C-Space>H` will `resize_left` by `(10 * config.default_amount)`
        map("n", "<C-Space>H", splits.resize_left, { desc = "Resize left" })
        map("n", "<C-Space>J", splits.resize_down, { desc = "Resize right" })
        map("n", "<C-Space>K", splits.resize_up, { desc = "Resize up" })
        map("n", "<C-Space>L", splits.resize_right, { desc = "Resize down" })
        -- moving between splits
        map("n", "<C-Space><C-h>", splits.move_cursor_left, { desc = "Move to left split" })
        map("n", "<C-Space><C-j>", splits.move_cursor_down, { desc = "Move to split below" })
        map("n", "<C-Space><C-k>", splits.move_cursor_up, { desc = "Move to split above" })
        map("n", "<C-Space><C-l>", splits.move_cursor_right, { desc = "Move to right split" })
        map("n", "<C-Space><C-\\>", splits.move_cursor_previous, { desc = "Move to previous split" })
        -- swapping buffers between windows
        -- vim.keymap.set("n", "<leader><leader>h", splits.swap_buf_left)
        -- vim.keymap.set("n", "<leader><leader>j", splits.swap_buf_down)
        -- vim.keymap.set("n", "<leader><leader>k", splits.swap_buf_up)
        -- vim.keymap.set("n", "<leader><leader>l", splits.swap_buf_right)
    end,
}
