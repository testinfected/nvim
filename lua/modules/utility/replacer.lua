return {
    "gabrielpoca/replacer.nvim",
    keys = {
        {
            "<leader>r",
            function()
                require("replacer").run()
            end,
            mode = "n",
            desc = "Replace in quickfix list",
        },
    },
}
