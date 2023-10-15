--[[
  Description: Base settings for neovim
  Info: Use <zo> and <zc> to open and close foldings
]]

-- Set associating between turned on plugins and filetype
vim.cmd [[filetype plugin on]]

-- Disable comments on pressing Enter
vim.cmd [[autocmd FileType * setlocal formatoptions-=cro]]

-- Set leader and local leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = ','
vim.keymap.set({ 'n', 'v' }, '<leader>', '<Nop>', { silent = true })

-- Buffers {{{
vim.o.autoread = true -- reload file if changed outside nvim
vim.o.autowrite = true
-- }}},

-- Buffers {{{
vim.o.autoread = true -- reload file if changed outside nvim
vim.o.autowrite = true -- autowrite file
---}}},

-- Tabs {{{
vim.o.expandtab = true -- Use spaces by default
vim.o.shiftwidth = 4 -- Set amount of space characters, when we press '<' or '>'
vim.o.tabstop = 4 -- 1 tab equal 2 spaces
vim.o.smartindent = true -- Turn on smart indentation. See in the docs for more info
-- }}}

-- Useful options {{{
vim.o.number = true -- Show line numbers
vim.o.cursorline = true
vim.o.cursorlineopt = 'number'
vim.o.mouse = 'a' -- Enable mouse in all modes,
vim.o.timeout = true
vim.o.timeoutlen = 200 -- Wait no more that 200ms for key mappings to complete, change according to your typing speed
-- }}}

-- Clipboard {{{
-- Let's use registers explicitly
-- clipboard = 'unnamed,unnamedplus' -- Use system clipboard
vim.o.fixeol = false -- Turn off appending new line in the end of a file
-- }}}

-- Search {{{
vim.o.ignorecase = true -- Ignore case if all characters in lower case
vim.o.joinspaces = false -- Join multiple spaces in search
vim.o.incsearch = true
vim.o.smartcase = true -- When there is a one capital letter search for exact match
vim.o.showmatch = true -- Highlight search instances
-- }}}

-- Sessions {{{
vim.o.sessionoptions = 'buffers,curdir,globals,tabpages,winpos,winsize' -- Save these in session
vim.o.backup = false -- Don't create a backup file
-- }}}

-- Term {{{
-- Adding true color
vim.o.termguicolors = true
-- }}}

-- Window {{{
vim.o.splitbelow = true -- Put new windows below current
vim.o.splitright = true -- Put new vertical splits to right
-- }}}

-- Wild Menu {{{
vim.o.wildmenu = true
vim.o.wildmode = 'longest:full,full'
-- }}}

-- Cmdline {{{
vim.o.cmdwinheight = 10
vim.o.ruler = false
-- }}}

vim.g.VM_set_statusline = 0 -- disable VM's statusline updates to prevent clobbering
vim.g.VM_silent_exit = 1

-- vim: tabstop=2 shiftwidth=2 expandtab syntax=lua foldmethod=marker foldlevelstart=1
