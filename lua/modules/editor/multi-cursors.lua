--[[
  Description: Multiple cursors for vim/neovim
  See: https://github.com/mg979/vim-visual-multi
]]

local M = {
    'mg979/vim-visual-multi',
    event = 'BufEnter'
}

function M.config()
    vim.g.VM_leader = '\\'
end

return M
