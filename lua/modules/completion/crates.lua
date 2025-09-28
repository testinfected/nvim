return {
    "saecki/crates.nvim",
    ft = { "toml" },
    config = function()
        require("crates").setup({
            lsp = {
                enabled = true,
                actions = true,
                completion = true,
                hover = true,
            },
            completion = {
                crates = {
                    enabled = true, -- disabled by default
                    max_results = 8, -- The maximum number of search results to display
                    min_chars = 3, -- The minimum number of characters to type before completions begin appearing
                },
            },
        })
    end,
}
