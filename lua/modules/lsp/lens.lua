local M = {
    'VidocqH/lsp-lens.nvim',
    event = 'LspAttach',
}

function M.config()
    require'lsp-lens'.setup({})
end

return M
