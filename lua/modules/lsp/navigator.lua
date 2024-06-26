local M = {
	"ray-x/navigator.lua",
	dependencies = {
		{ "ray-x/lsp_signature.nvim" },
		{ "ray-x/guihua.lua", run = "cd lua/fzy && make" },
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
			diagnostic_head_description = " ", -- suffix for severities
			diagnostic_virtual_text = icons.diagnostics.Diagnostic, -- floating text preview (set to empty to disable)
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
