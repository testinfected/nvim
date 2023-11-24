--[[
  Description: Custom keybindings
]]

local map = vim.keymap.set

map('n', 'x', '"_x') -- don't put cut characters in register
map('n', 'r', '"_r') -- don't put cut characters in register
map({ 'i', 'n' }, '<ESC>', [[<Cmd>noh<CR><ESC>]], { desc = "Escape and clear search highlighting" })

-- Break the habit of using arrow keys in normal mode. Not for the faint of heart!
--for _, arrow_key in ipairs({ '<Up>', '<Down>', '<Left>', '<Right>' }) do
--  map('n', arrow_key, '<Nop>')
--end

-- Better navigation in insert mode
map('i', '<C-h>', '<Left>', { desc = "Move left" })
map('i', '<C-l>', '<Right>', { desc = "Move right" })
map('i', '<C-j>', '<Down>', { desc = "Move down" })
map('i', '<C-k>', '<Up>', { desc = "Move up" })

-- Close buffer using <leader>q
map({'n', 't'}, '<leader>q', [[<Cmd>q<CR>]], { desc = "Close buffer" })

-- Save using CTRL-s and exit insert mode 
map({'n', 'i'}, '<C-s>', '<Cmd>w<CR><ESC>', { desc = "Save file", silent = true })

--The & command repeats the last substitution (synonym for :s).
-- Unfortunately, it disregards flags, so make & trigger the :&& command which preserves flags
map({'n', 'x'}, '&', '<Cmd>&&<CR>', { desc = "Repeat last substitution" })

-- Splits
map('n', '<leader>wv', '<C-w>v', { desc = "Vertically" })
map('n', '<leader>w|', '<C-w>v', { desc = "Vertically" })
map('n', '<leader>wh', '<C-w>s', { desc = "Horizontally" })
map('n', '<leader>w-', '<C-w>s', { desc = "Horizontally" })
map('n', '<leader>ww', '<C-w>w', { desc = "Switch" })
map('n', '<leader>wq', '<C-w>q', { desc = "Close" })
map('n', '<leader>w=', '<C-w>=', { desc = "Equal width" })

-- vim:tabstop=2 shiftwidth=2 expandtab syntax=lua foldmethod=marker foldlevelstart=0 foldlevel=0
