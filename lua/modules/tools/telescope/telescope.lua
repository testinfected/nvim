--[[
  Description: Fuzzy finder over lists
  See: https://github.com/nvim-telescope/telescope.nvim
]]

return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
        {
            -- much faster fzf than its lua counterpart
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
    },
    event = "VeryLazy",
    config = function()
        local telescope = require("telescope")
        local icons = require("config.icons")

        telescope.setup({
            defaults = {
                vimgrep_arguments = {
                    "rg",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                },
                mappings = {
                    i = {
                        -- map actions.which_key to <C-h> (default: <C-/>)
                        -- actions.which_key shows the mappings for your picker,
                        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                        ["<C-h>"] = "which_key",
                    },
                },
                prompt_prefix = " " .. icons.ui.Telescope .. " ",
                selection_caret = icons.ui.ChevronRight .. " ",
                multi_icon = icons.ui.Checkmark,
                scroll_strategy = "limit",
                results_title = false,
                layout_strategy = "horizontal",
                path_display = { "absolute" },
                selection_strategy = "reset",
                sorting_strategy = "ascending",
                color_devicons = true,
                file_ignore_patterns = { ".git/", ".cache", "build/", "%.class", "%.pdf", "%.mkv", "%.mp4", "%.zip" },
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                        preview_width = 0.55,
                        results_width = 0.8,
                    },
                    vertical = {
                        mirror = false,
                    },
                    width = 0.85,
                    height = 0.92,
                    preview_cutoff = 120,
                },
                file_previewer = require("telescope.previewers").vim_buffer_cat.new,
                grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
                qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
                file_sorter = require("telescope.sorters").get_fuzzy_file,
                generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
                buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
            },
            pickers = {
                buffers = {
                    initial_mode = "normal",
                },
                oldfiles = {
                    initial_mode = "normal",
                },
            },
            extensions = {
                fzf = {
                    fuzzy = false,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
            },
        })

        -- Super fast fuzzy find
        telescope.load_extension("fzf")

        -- Keybindings
        local builtin = require("telescope.builtin")

        local map = vim.keymap.set
        map("n", "<leader> ", builtin.buffers, { desc = "Select buffer" })
        map("n", "<leader>/", builtin.live_grep, { desc = "Search everywhere" })
        map("n", "<leader>*", builtin.grep_string, { desc = "Find word under cursor" })

        -- +Find
        map("n", "<leader>fb", function()
            builtin.buffers({ show_all_buffers = true })
        end, { desc = "Buffer" })
        map("n", "<leader>fc", builtin.command_history, { desc = "Recent command" })
        map("n", "<leader>ff", builtin.resume, { desc = "Resume last search" })
        map("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
        map("n", "<leader>fh", builtin.help_tags, { desc = "Help" })
        map("n", "<leader>fk", builtin.keymaps, { desc = "Key" })
        map("n", "<leader>fm", builtin.marks, { desc = "Mark" })
        map("n", "<leader>fo", builtin.find_files, { desc = "Open File" })
        map("n", "<leader>fr", builtin.oldfiles, { desc = "Recent file" })
        map("n", "<leader>ft", builtin.current_buffer_fuzzy_find, { desc = "Text in current buffer" })
        map("n", "<leader>fw", builtin.grep_string, { desc = "Word under cursor" })

        -- +help
        map("n", "<leader>hc", builtin.commands, { desc = "Show available commands" })
        map("n", "<leader>ho", builtin.vim_options, { desc = "Show options" })
        map("n", "<leader>hh", builtin.highlights, { desc = "Show highlight groups" })
    end,
}
