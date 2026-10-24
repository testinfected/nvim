--[[
  Description: Configuration of tree-sitter in Neovim
  See: https://github.com/nvim-treesitter/nvim-treesitter
]]

return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = [[:TSUpdate]],
    event = { "BufRead" },
    config = function()
        local desired = {
            "comment",
            "cue",
            "go",
            "gomod",
            "gosum",
            "javascript",
            "json",
            "lua",
            "make",
            "markdown",
            "markdown_inline",
            "python",
            "regex",
            -- "ruby",
            "rust",
            "ron",
            -- "typescript",
            "vim",
            "vimdoc",
            "yaml",
            -- ... your parsers
        }
        local installed = require('nvim-treesitter.config').get_installed()
        local missing = vim.iter(desired)
            :filter(function(parser)
                return not vim.tbl_contains(installed, parser)
            end)
            :totable()
        require('nvim-treesitter').install(missing)

        -- todo add to respective modules
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "lua", "go", "gomod", "rust", "cue", "python" },
            callback = function()
                pcall(vim.treesitter.start)
                -- Enable treesitter-based indentation
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
}
