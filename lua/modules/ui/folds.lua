local M = {
    "chrisgrieser/nvim-origami",
    event = 'BufEnter'
}

function M.config()
    -- recommended: disable vim's auto-folding
    vim.opt.foldlevel = 99
    vim.opt.foldlevelstart = 99
    local origami = require('origami')
    origami.setup({
    })
end

return M
