local M = {
    "ray-x/navigator.lua",
    dependencies = {
        { "ray-x/lsp_signature.nvim" },
        { "ray-x/guihua.lua",        run = "cd lua/fzy && make" },
        { "neovim/nvim-lspconfig" },
    },
    event = { "VeryLazy" },
}

function M.config()
    require("navigator").setup({
        mason = true,
        lsp_signature_help = true,
        default_mapping = false,
        keymaps = {
            {
                key = "<leader>nr",
                func = require("navigator.reference").async_ref,
                desc = "Reference",
            },
            {
                key = "<leader>nd",
                func = require("navigator.definition").definition,
                desc = "Definition",
            },
            {
                key = "<leader>np",
                func = require("navigator.definition").definition_preview,
                desc = "Definition Preview",
            },
            {
                key = "<leader>nt",
                func = vim.lsp.buf.type_definition,
                desc = "Type Definition",
            },
            {
                key = "<leader>nu",
                func = require("navigator.definition").type_definition_preview,
                desc = "Type Definition Preview",
            },
            {
                key = "<leader>ni",
                func = vim.lsp.buf.incoming_calls,
                desc = "Incoming Calls",
            },
            {
                key = "<leader>no",
                func = vim.lsp.buf.outgoing_calls,
                desc = "Outgoing Calls",
            },
            {
                key = "<leader>nb",
                func = vim.lsp.buf.implementation,
                desc = "Implementation",
            },
            {
                key = "<leader>nk",
                func = require("navigator.dochighlight").hi_symbol,
                desc = "Highlight Symbol",
            },
            {
                key = "<leader>ns",
                func = vim.lsp.buf.signature_help,
                desc = "Signature",
            },
            {
                key = "<leader>ca",
                mode = "n",
                func = require("navigator.codeAction").code_action,
                desc = "Code Action",
            },
            {
                key = "<leader>ca",
                mode = "v",
                func = require("navigator.codeAction").range_code_action,
                desc = "Range Code Action",
            },
            {
                key = "<leader>cl",
                mode = "n",
                func = require("navigator.codelens").run_action,
                desc = "Code Lens Action",
            },
            {
                key = "<leader>cf",
                func = require("navigator.formatting").range_format,
                mode = "n",
                desc = "Range Format Operator",
            },
            {
                key = "<leader>cs",
                func = require("navigator.symbols").document_symbols,
                desc = "Document Symbols",
            },
            {
                key = "<leader>cw",
                func = require("navigator.workspace").workspace_symbol_live,
                desc = "Workspace Symbols",
            },
            {
                key = "<leader>cr",
                func = require("navigator.rename").rename,
                desc = "Rename",
            },
            -- Diagnostics
            {
                key = "<leader>cdw",
                func = require("navigator.diagnostics").show_diagnostics,
                desc = "Workspace Diagnostics",
            },
            {
                key = "<leader>cdb",
                func = require("navigator.diagnostics").show_buf_diagnostics,
                desc = "Buffer diagnostics",
            },
            {
                key = "<leader>cdt",
                func = require("navigator.diagnostics").toggle_diagnostics,
                desc = "Toggle Diagnostics",
            },
            {
                key = "]d",
                func = require("navigator.diagnostics").goto_next,
                desc = "Next Error",
            },
            {
                key = "[d",
                func = require("navigator.diagnostics").goto_prev,
                desc = "Prev Error",
            },
            {
                key = "]r",
                func = require("navigator.treesitter").goto_next_usage,
                desc = "Next Usage",
            },
            {
                key = "[r",
                func = require("navigator.treesitter").goto_previous_usage,
                desc = "Previous Usage",
            },
        },
    })
end

return M
