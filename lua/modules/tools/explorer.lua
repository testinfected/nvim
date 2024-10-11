--[[
  Description: Browse the file system and other tree like structures
  See: https://github.com/nvim-tree/rvim-tree.lua
]]

local M = {
    "nvim-tree/nvim-tree.lua",
    keys = {
        { "<leader>e", [[<Cmd>NvimTreeToggle<CR>]], desc = "File explorer" },
    },
    init = function()
        vim.cmd([[autocmd Filetype NvimTree set cursorline | set statuscolumn=]])
    end
}

function M.config()
    local icons = require("config.icons")

    require("nvim-tree").setup({
        view = {
            width = 40,
        },
        renderer = {
            icons = {
                glyphs = {
                    git = {
                        unstaged = icons.git.FileUnstaged,
                        untracked = icons.git.FileUntracked,
                    },
                },
            },
        },
        diagnostics = {
            icons = {
                hint = icons.diagnostics.Hint,
                info = icons.diagnostics.Info,
                warning = icons.diagnostics.Warning,
                error = icons.diagnostics.Error,
            },
        },
        update_focused_file = {
            enable = true,
            ignore_list = {},
        },
    })

    vim.keymap.set("n", "<leader>fl", "<Cmd>NvimTreeFindFile<CR>", { desc = "Locate in explorer" })
end

return M
