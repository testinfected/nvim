--[[
  Description: File browser extension for telescope.nvim
  See: https://github.com/nvim-telescope/telescope-file-browser.nvim
]]

return {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = {
        "nvim-telescope/telescope.nvim",
    },
    keys = {
        { "<leader>.", [[<Cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>]], desc = "Browse files" },
    },
    config = function()
        local telescope = require("telescope")

        telescope.setup({
            extensions = {
                file_browser = {
                    initial_mode = "normal",
                    -- disables netrw and use telescope-file-browser in its place
                    hijack_netrw = true,
                    mappings = {
                        ["i"] = {
                            -- your custom insert mode mappings
                        },
                        ["n"] = {
                            -- your custom normal mode mappings
                        },
                    },
                },
            },
        })

        telescope.load_extension("file_browser")
    end,
}
