--[[
  Description: Modern looking folds
  See: https://github.com/kevinhwang91/nvim-ufo
]]

return {
    "kevinhwang91/nvim-ufo",
    dependencies = {
        "kevinhwang91/promise-async",
    },
    event = "VeryLazy",
    config = function()
        local ufo = require("ufo")

        vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
        vim.o.foldcolumn = "1" -- fold column with, 0 will hide it
        vim.o.foldlevel = 99 -- start with all folds opened
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true
        vim.o.foldmethod = "expr"
        vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

        -- Tell the server the capability of foldingRange,
        -- Neovim hasn't added foldingRange to default capabilities, users must add it manually
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
        }
        local language_servers = vim.lsp.get_clients() -- or list servers manually like {'gopls', 'clangd'}
        for _, ls in ipairs(language_servers) do
            require("lspconfig")[ls].setup({
                capabilities = capabilities,
                -- you can add other fields for setting up lsp server in this table
            })
        end

        ufo.setup({
            open_fold_hl_timeout = 150,
            close_fold_kinds_for_ft = { default = { "imports", "comment" } },
            preview = {
                win_config = {
                    winhighlight = "Normal:Folded",
                    winblend = 0,
                },
                mappings = {
                    scrollU = "<C-u>",
                    scrollD = "<C-d>",
                    jumpTop = "[",
                    jumpBot = "]",
                },
            },
            -- show folded lines count
            fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
                local text = {}
                local suffix = (" 󰁂 %d "):format(endLnum - lnum)
                local currentWidth = 0
                local targetWidth = width - vim.fn.strdisplaywidth(suffix)

                for _, chunk in ipairs(virtText) do
                    local chunkText = chunk[1]
                    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    if targetWidth > currentWidth + chunkWidth then
                        table.insert(text, chunk)
                    else
                        chunkText = truncate(chunkText, targetWidth - currentWidth)
                        local hlGroup = chunk[2]
                        table.insert(text, { chunkText, hlGroup })
                        chunkWidth = vim.fn.strdisplaywidth(chunkText)
                        -- str width returned from truncate() may less than 2nd argument, need padding
                        if currentWidth + chunkWidth < targetWidth then
                            suffix = suffix .. (" "):rep(targetWidth - currentWidth - chunkWidth)
                        end
                        break
                    end
                    currentWidth = currentWidth + chunkWidth
                end

                table.insert(text, { suffix, "MoreMsg" })
                return text
            end,
        })

        local map = vim.keymap.set
        map("n", "zR", ufo.openAllFolds, { desc = "Open all folds" })
        map("n", "zM", ufo.closeAllFolds, { desc = "Close all folds" })
        map("n", "zp", ufo.peekFoldedLinesUnderCursor, { desc = "Preview fold content" }) -- closeAllFolds == closeFoldsWith(0)
    end,
}
