--[[
  Description: Super fast git decorations
  See: https://github.com/lewis6991/gitsigns.nvim
]]

return {
	"lewis6991/gitsigns.nvim",
	event = { "VeryLazy" },
	config = function()
		local git = require("gitsigns")

		git.setup({
			current_line_blame = true,
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "right_align",
				delay = 1000,
				ignore_whitespace = false,
			},
			preview_config = {
				-- Options passed to nvim_open_win
				style = "minimal",
				relative = "cursor",
				row = 0,
				col = 1,
			},
			on_attach = function(bufnr)
				-- Navigation
				local next_hunk = function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						git.next_hunk()
					end)
					return "<Ignore>"
				end

				local prev_hunk = function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						git.prev_hunk()
					end)
					return "<Ignore>"
				end

				local map, prefix = vim.keymap.set, "<leader>g"
				local function opts(values)
					values.buffer = bufnr
					return values
				end

				map("n", "]h", next_hunk, opts({ desc = "Next hunk", expr = true }))
				map("n", "[h", prev_hunk, opts({ desc = "Previous hunk", expr = true }))

				-- +git actions
				map("n", prefix .. "h", git.stage_hunk, opts({ desc = "Stage [h]unk" }))
				map("n", prefix .. "r", git.reset_hunk, opts({ desc = "Reset hunk" }))
				map("n", prefix .. "u", git.undo_stage_hunk, opts({ desc = "Undo stage hunk" }))
				map("n", prefix .. "p", git.preview_hunk, opts({ desc = "Preview hunk" }))
				-- Text objects
				map({ "o", "x" }, "ih", [[<Cmd>Gitsigns select_hunk]], { buffer = bufnr, desc = "Select hunk" })
			end,
		})
	end,
}
