--[[
  Description: Install debug adapters via Mason
  See: https://github.com/jay-babu/mason-nvim-dap.nvim
]]

return {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
        "williamboman/mason.nvim",
        "mfussenegger/nvim-dap",
    },
    event = "LspAttach",
    cmd = { "DapInstall", "DapUninstall" },
    config = function()
        require("mason-nvim-dap").setup({
            ensure_installed = {
                --"python",
                "codelldb",
                "delve",
            },
        })
    end,
}
