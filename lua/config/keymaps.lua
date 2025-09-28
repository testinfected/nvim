--[[
  Description: Custom keybindings
]]

local map = vim.keymap.set

map("n", "x", '"_x', { desc = "Delete character under cursor" }) -- don't put cut characters in register
map("n", "r", '"_r', { desc = "Replace character under cursor" }) -- don't put cut characters in register
map({ "i", "n" }, "<ESC>", [[<Cmd>noh<CR><ESC>]], { desc = "Escape and clear search highlighting" })

-- Break the habit of using arrow keys in normal mode. Not for the faint of heart!
for _, arrow_key in ipairs({ "<Up>", "<Down>", "<Left>", "<Right>" }) do
	map("n", arrow_key, "<Nop>")
end


-- Save using CTRL-s and exit insert mode
map({ "n", "i" }, "<C-s>", "<Cmd>w<CR><ESC>", { desc = "Save file", silent = true })

-- In insert mode map CTRL-L, which is not mapped, to delete character under cursor
-- This matches CTRL-H which does backspace
map("i", "<C-l>", "<Del>", { remap = true })
-- CTRL-j (CR) and CTRL-k (digrams) have little use so remap them to left and right cursor keys for small movements
-- without leaving insert mode. Not true used by completion menu
-- map("i", "<C-j>", "<Left>")
-- map("i", "<C-k>", "<Right>")

--The & command repeats the last substitution (synonym for :s).
-- Unfortunately, it disregards flags, so make & trigger the :&& command which preserves flags
map({ "n", "x" }, "&", "<Cmd>&&<CR>", { desc = "Repeat last substitution" })

-- Splits
map("n", "<leader>wv", "<C-w>v", { desc = "Vertically" })
map("n", "<leader>w|", "<C-w>v", { desc = "Vertically" })
map("n", "<leader>wh", "<C-w>s", { desc = "Horizontally" })
map("n", "<leader>w-", "<C-w>s", { desc = "Horizontally" })
map("n", "<leader>ww", "<C-w>w", { desc = "Switch" })
map("n", "<leader>wq", "<C-w>q", { desc = "Close" })
map("n", "<leader>w=", "<C-w>=", { desc = "Equal width" })

-- vim:tabstop=2 shiftwidth=2 expandtab syntax=lua foldmethod=marker foldlevelstart=0 foldlevel=0
