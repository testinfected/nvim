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
    local icons = require("config.icons")
    require("navigator").setup({
        mason = true,
        lsp_signature_help = true,
        default_mapping = false,
        lsp = {
            enable = true,
            code_action = { enable = true, sign = true, sign_priority = 40, virtual_text = true },
            code_lens_action = { enable = true, sign = true, sign_priority = 40, virtual_text = true },
            document_highlight = true, -- LSP reference highlight,
            format_on_save = true,
            format_options = { async = true },
            disable_format_cap = {}, -- a list of lsp disable format capacity (e.g. if you using efm or vim-codeformat etc), empty {} by default
        },
        icons = {
            -- Code Action (gutter, floating window)
            code_action_icon = icons.diagnostics.Action .. " ",

            -- Code Lens (gutter, floating window)
            code_lens_action_icon = "👓",

            -- Diagnostics (gutter)
            -- diagnostic_head = icons.diagnostics.Diagnostic, -- prefix for other diagnostic_* icons
            diagnostic_head = "", -- prefix for other diagnostic_* icons
            diagnostic_err = icons.diagnostics.Error,
            diagnostic_warn = icons.diagnostics.Warning,
            diagnostic_info = icons.diagnostics.Info,
            diagnostic_hint = icons.diagnostics.Hint,

            -- Diagnostics (floating window)
            diagnostic_head_severity_1 = icons.diagnostics.Error,
            diagnostic_head_severity_2 = icons.diagnostics.Warning,
            diagnostic_head_severity_3 = icons.diagnostics.Info,
            diagnostic_head_description = " ",              -- suffix for severities
            -- diagnostic_virtual_text = icons.diagnostics.Diagnostic, -- floating text preview (set to empty to disable)
            diagnostic_virtual_text = "",                   -- floating text preview (set to empty to disable)
            diagnostic_file = icons.diagnostics.Diagnostic, -- icon in floating window, indicates the file contains diagnostics

            -- Values (floating window)
            value_definition = "", -- identifier defined
            value_changed = "", -- identifier modified
            context_separator = " ", -- separator between text and value

            -- Formatting for Side Panel
            side_panel = {
                section_separator = "󰇜",
                line_num_left = "",
                line_num_right = "",
                inner_node = "├○",
                outer_node = "╰○",
                bracket_left = "⟪",
                bracket_right = "⟫",
                tab = "󰌒",
            },
            fold = {
                prefix = "⚡",
                separator = "",
            },

            -- Treesitter
            -- Note: many more node.type or kind may be available
            match_kinds = {
                var = icons.kind.Variable .. " ", -- variable --
                const = icons.kind.Constant .. " ",
                method = icons.kind.Method .. " ",
                -- function is a keyword so wrap in ['key'] syntax
                ["function"] = icons.kind.Function .. " ",
                parameter = icons.kind.Parameter .. " ",
                parameters = icons.kind.Parameter .. " ",
                require_parameter = icons.kind.Parameter .. " ",
                associated = icons.kind.Reference .. " ", -- linked/related
                namespace = icons.kind.Namespace .. " ",
                type = icons.kind.Type .. " ",
                field = icons.kind.Field .. " ",
                module = icons.kind.Module .. " ",
                flag = icons.kind.Event .. " ",
            },
            treesitter_defult = icons.lsp.Treesitter .. " ", -- default symbol when unknown node.type or kind
            doc_symbols = "", -- document
        },
        keymaps = {
            {
                key = "gd",
                func = require("navigator.definition").definition,
                desc = "Definition",
            },
            {
                key = "<leader>nd",
                func = require("navigator.definition").definition,
                desc = "Definition",
            },
            {
                key = "gr",
                func = require("navigator.reference").async_ref,
                desc = "Reference",
            },
            {
                key = "<leader>nr",
                func = require("navigator.reference").async_ref,
                desc = "Reference",
            },
            {
                key = "<leader>nt",
                func = vim.lsp.buf.type_definition,
                desc = "Type Definition",
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
                key = "<leader>ns",
                func = require("navigator.symbols").document_symbols,
                desc = "Document Symbols",
            },
            {
                key = "<leader>nw",
                func = require("navigator.workspace").workspace_symbol_live,
                desc = "Workspace Symbols",
            },
            {
                key = "<leader>nb",
                func = vim.lsp.buf.implementation,
                desc = "Implementation",
            },
            {
                key = "<leader>ca",
                mode = "n",
                func = require("navigator.codeAction").code_action,
                desc = "Action",
            },
            {
                key = "<leader>ca",
                mode = "v",
                func = require("navigator.codeAction").range_code_action,
                desc = "Ranged action",
            },
            {
                key = "<leader>ch",
                func = require("navigator.dochighlight").hi_symbol,
                desc = "Highlight symbol",
            },
            {
                key = "<leader>cl",
                mode = "n",
                func = require("navigator.codelens").run_action,
                desc = "Lens",
            },
            {
                key = "<leader>cf",
                func = require("navigator.formatting").format_hdl,
                mode = "n",
                desc = "Format",
            },
            {
                key = "<leader>cf",
                func = require("navigator.formatting").range_format,
                mode = "v",
                desc = "Format selected",
            },
            {
                key = "<leader>cd",
                func = require("navigator.definition").definition_preview,
                desc = "Preview definition",
            },
            {
                key = "<leader>ct",
                func = require("navigator.definition").type_definition_preview,
                desc = "Preview type definition",
            },
            {
                key = "<leader>cr",
                func = require("navigator.rename").rename,
                desc = "Rename",
            },
            {
                key = "<leader>ns",
                func = vim.lsp.buf.signature_help,
                desc = "Signature",
            },
            -- Diagnostics
            {
                key = "<leader>cdw",
                func = require("navigator.diagnostics").show_diagnostics,
                desc = "Workspace",
            },
            {
                key = "<leader>cdb",
                func = require("navigator.diagnostics").show_buf_diagnostics,
                desc = "Buffer",
            },
            {
                key = "<leader>cdt",
                func = require("navigator.diagnostics").toggle_diagnostics,
                desc = "Toggle",
            },
            {
                key = "]d",
                func = require("navigator.diagnostics").goto_next,
                desc = "Jump to next diagnostic",
            },
            {
                key = "[d",
                func = require("navigator.diagnostics").goto_prev,
                desc = "Jump to previous diagnostic",
            },
            {
                key = "]u",
                func = require("navigator.treesitter").goto_next_usage,
                desc = "Jumpt to next usage",
            },
            {
                key = "[u",
                func = require("navigator.treesitter").goto_previous_usage,
                desc = "Jump to previous usage",
            },
        },
    })
end

return M
