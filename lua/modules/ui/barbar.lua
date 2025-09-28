return {
    "romgrk/barbar.nvim",
    dependencies = {
        "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
        "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
    },
    event = { "VimEnter" },
    config = function()
        vim.g.barbar_auto_setup = false

        local icons = require("config.icons")
        require("barbar").setup({
            auto_hide = 1,
            icons = {
                -- Configure the base icons on the bufferline.
                -- Valid options to display the buffer index and -number are `true`, 'superscript' and 'subscript'
                buffer_index = "superscript",
                buffer_number = false,
                button = icons.ui.Close,
                -- Enables / disables diagnostic symbols
                diagnostics = {
                    [vim.diagnostic.severity.ERROR] = { enabled = true, icon = icons.diagnostics.Error },
                },
                filetype = {
                    -- Sets the icon's highlight group.
                    -- If false, will use nvim-web-devicons colors
                    custom_colors = false,
                    -- Requires `nvim-web-devicons` if `true`
                    enabled = true,
                },
                separator = { left = icons.ui.LeftBorderLine, right = "" },

                -- If true, add an additional separator at the end of the buffer list
                separator_at_end = true,

                -- Configure the icons on the bufferline when modified or pinned.
                -- Supports all the base icon options.
                modified = { button = icons.file.Modified },
                pinned = { button = icons.file.Pinned, filename = true },
            },
            -- Set the filetypes which barbar will offset itself for
            sidebar_filetypes = {
                -- Use the default values: {event = 'BufWinLeave', text = '', align = 'left'}
                NvimTree = true,
            },
        })

        local map = vim.keymap.set
        map("n", "<leader>1", [[<Cmd>BufferGoto 1<CR>]], { desc = "Go to buffer 1" })
        map("n", "<leader>2", [[<Cmd>BufferGoto 2<CR>]], { desc = "Go to buffer 2" })
        map("n", "<leader>3", [[<Cmd>BufferGoto 3<CR>]], { desc = "Go to buffer 3" })
        map("n", "<leader>4", [[<Cmd>BufferGoto 4<CR>]], { desc = "Go to buffer 4" })
        map("n", "<leader>5", [[<Cmd>BufferGoto 5<CR>]], { desc = "Go to buffer 5" })
        map("n", "<leader>6", [[<Cmd>BufferGoto 6<CR>]], { desc = "Go to buffer 6" })
        map("n", "<leader>7", [[<Cmd>BufferGoto 7<CR>]], { desc = "Go to buffer 7" })
        map("n", "<leader>8", [[<Cmd>BufferGoto 8<CR>]], { desc = "Go to buffer 8" })
        map("n", "<leader>9", [[<Cmd>BufferGoto 9<CR>]], { desc = "Go to buffer 9" })
        map("n", "<leader>0", [[<Cmd>BufferLast<CR>]], { desc = "Go to last buffer" })

        -- Move to previous/next
        map("n", "<leader>bj", "<Cmd>BufferPrevious<CR>", { desc = "Previous" })
        map("n", "<leader>bk", "<Cmd>BufferNext<CR>", { desc = "Next" })
        -- Re-order to previous/next
        map("n", "<leader>b,", "<Cmd>BufferMovePrevious<CR>", { desc = "Move left" })
        map("n", "<leader>b.", "<Cmd>BufferMoveNext<CR>", { desc = "Move right" })
        -- Pin/unpin buffer
        map("n", "<leader>bp", "<Cmd>BufferPin<CR>", { desc = "Pin/unpin" })
        -- Close buffer
        map("n", "<leader>bc", "<Cmd>BufferClose<CR>", { desc = "Close" })
        map("n", "<leader>bs", "<Cmd>BufferPick<CR>", { desc = "Pick" })
        -- Wipeout buffer
        --                 :BufferWipeout
        -- Close commands
        --                 :BufferCloseAllButCurrent
        --                 :BufferCloseAllButPinned
        --                 :BufferCloseAllButCurrentOrPinned
        --                 :BufferCloseBuffersLeft
        --                 :BufferCloseBuffersRight
        -- Sort automatically by...
        -- :BufferOrderByBufferNumber
        -- :BufferOrderByName
        -- :BufferOrderByDirectory
        -- :BufferOrderByLanguage
        -- :BufferOrderByWindowNumber

        -- Other:
        -- :BarbarEnable - enables barbar (enabled by default)
        -- :BarbarDisable - very bad command, should never be used
    end,
}
