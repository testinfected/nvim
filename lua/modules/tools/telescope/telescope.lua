--[[
  File: telescope.lua
  Description: Fuzzy finder over lists
  See: https://github.com/nvim-telescope/telescope.nvim
]]

local M = {
    'nvim-telescope/telescope.nvim',
    version = '0.1.2',
    dependencies = {
        'nvim-lua/popup.nvim',
        'nvim-lua/plenary.nvim',
        {
            -- much faster fzf than its lua counterpart
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
        },
    },
    event = 'VeryLazy'
}

local function setup_keymaps()
    local builtin = require('telescope.builtin')

    local map = vim.keymap.set
    map('n', '<leader> ', builtin.find_files, { desc = "Find file" })
    map('n', '<leader>;', builtin.buffers, { desc = "Select buffer" })
    map('n', '<leader>/', builtin.live_grep, { desc = "Search everywhere" })
    map('n', '<leader>:', builtin.command_history, { desc = "Search command history" })
    map('n', '<leader>*', builtin.grep_string, { desc = "Find word under cursor" })

    -- +buffer
    map('n', '<leader>bf', builtin.find_files, { desc = "Open from workspace" })
    map('n', '<leader>bo', builtin.git_files, { desc = "Open from project" })
    map('n', '<leader>br', builtin.oldfiles, { desc = "Open recent" })
    map('n', '<leader>bs', function() builtin.buffers({ show_all_buffers = true }) end, { desc = "Select" })

    -- +Find
    map('n', '<leader>fb', builtin.current_buffer_fuzzy_find, { desc = "Text in current buffer" })
    map('n', '<leader>fc', builtin.command_history, { desc = "Recent command" })
    map('n', '<leader>fm', builtin.marks, { desc = "Mark" })
    map('n', '<leader>fr', builtin.resume, { desc = "Resume last search" })
    map('n', '<leader>ft', builtin.live_grep, { desc = "Text everywhere" })
    map('n', '<leader>fw', builtin.grep_string, { desc = "Word under cursor" })

    -- +help
    map('n', '<leader>hc', builtin.commands, { desc = "Show available commands" })
    map('n', '<leader>hk', builtin.keymaps, { desc = "Show keymaps" })
    map('n', '<leader>ho', builtin.vim_options, { desc = "Show options" })
    map('n', '<leader>hh', builtin.help_tags, { desc = "Show help tags" })
    map('n', '<leader>hH', builtin.highlights, { desc = "Show highlight groups" })
end

function M.config()
    local telescope = require('telescope')
    local icons = require('config.icons')

    telescope.setup {
        defaults = {
            vimgrep_arguments = {
                "rg",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case",
            },
            initial_mode = "insert",
            prompt_prefix = " " .. icons.ui.Telescope .. " ",
            selection_caret = icons.ui.ChevronRight,
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
        extensions = {
            fzf = {
                fuzzy = false,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case",
            },
        },
    }

    -- Super fast fuzzy find
    telescope.load_extension('fzf')

    -- Keybindings
    setup_keymaps()
end

return M
