return {
    "swaits/lazyjj.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = "Lazyjj",
    keys = {
        { "<leader>jj", "<cmd>Lazyjj<CR>", desc = "Open lazyjj" },
    },
    opts = {
        mapping = '<leader>jj'
    }
}
