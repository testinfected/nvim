--[[
  Description: Select your VirtualEnv directly from NeoVim
  See: https://github.com/linux-cultist/venv-selector.nvim
]]

local M = {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        "nvim-telescope/telescope.nvim",
        "mfussenegger/nvim-dap-python"
    },
    event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
    keys = {
        { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select virtual environment" }
    }
}

function M.config()
    require('venv-selector').setup {
        name = { "venv", ".venv" },
        dap_enabled = true,
        pyenv_path = vim.fn.expand("$HOME/.pyenv/versions"),
    }
end

return M
