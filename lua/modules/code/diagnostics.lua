--[[
  Description: A pretty diagnostics, references, telescope results, quickfix and location list
  See: https://github.com/folke/trouble.nvim
]]

local M = {
    "folke/trouble.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    event = "VeryLazy",
    keys = {
        {
            "<leader>xw",
            "<cmd>Trouble diagnostics open<cr>",
            desc = "Workspace diagnostics",
        },
        {
            "<leader>xj",
            "<cmd>Trouble diagnostics focus<cr>",
            desc = "Jump to diagnostics",
        },
        {
            "<leader>xd",
            "<cmd>Trouble diagnostics open filter.buf=0<cr>",
            desc = "Document diagnostics",
        },
        {
            "<leader>xl",
            "<cmd>Trouble loclist toggle<cr>",
            desc = "Locations",
        },
        {
            "<leader>xq",
            "<cmd>Trouble qflist toggle<cr>",
            desc = "Quickfix",
        },
    },
}

local function set_sign_icons(opts)
    opts = opts or {}

    local sign = function(args)
        if opts[args.name] == nil then
            return
        end

        vim.fn.sign_define(args.hl, {
            texthl = args.hl,
            text = opts[args.name],
            numhl = "",
        })
    end

    sign({ name = "error", hl = "DiagnosticSignError" })
    sign({ name = "warn", hl = "DiagnosticSignWarn" })
    sign({ name = "hint", hl = "DiagnosticSignHint" })
    sign({ name = "info", hl = "DiagnosticSignInfo" })
end

function M.config()
    require("trouble").setup()

    local telescope = require("trouble.sources.telescope")
    require("telescope").setup({
        defaults = {
            mappings = {
                i = { ["<c-t>"] = telescope.open },
                n = { ["<c-t>"] = telescope.open },
            },
        },
    })

    -- Custom sign icons
    local icons = require("config.icons")
    set_sign_icons({
        error = icons.diagnostics.Error,
        warn = icons.diagnostics.Warning,
        hint = icons.diagnostics.Hint,
        info = icons.diagnostics.Info,
    })
end

return M
