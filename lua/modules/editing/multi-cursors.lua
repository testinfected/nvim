--[[
  Description: Multiple cursors for neovim
  See: https://github.com/brenton-leighton/multiple-cursors.nvim
]]

return {
	"jake-stewart/multicursor.nvim",
	config = function()
		local mc = require("multicursor-nvim")
		mc.setup()

		local set = vim.keymap.set

		-- Add or skip cursor above/below the main cursor.
		set({ "n", "x" }, "<c-k>", function()
			mc.lineAddCursor(-1)
		end, { desc = "Add cursor above" })
		set({ "n", "x" }, "<c-j>", function()
			mc.lineAddCursor(1)
		end, { desc = "Add cursor below" })
		set({ "n", "x" }, "<c-h>", function()
			mc.lineSkipCursor(-1)
		end, { desc = "Skip cursor at line above" })
		set({ "n", "x" }, "<c-l>", function()
			mc.lineSkipCursor(1)
		end, { desc = "Skip cursor at line below" })

		-- Add or skip adding a new cursor by matching word/selection
		set({ "n", "x" }, "<M-j>", function()
			mc.matchAddCursor(1)
		end, { desc = "Add cursor at next match" })
		set({ "n", "x" }, "<M-l>", function()
			mc.matchSkipCursor(1)
		end, { desc = "Skip cursor at next match" })
		set({ "n", "x" }, "<M-k>", function()
			mc.matchAddCursor(-1)
		end, { desc = "Add cursor at previous match" })
		set({ "n", "x" }, "<M-h>", function()
			mc.matchSkipCursor(-1)
		end, { desc = "Skip cursor at previous match" })

		-- Add and remove cursors with control + left click.
		set("n", "<c-leftmouse>", mc.handleMouse)
		set("n", "<c-leftdrag>", mc.handleMouseDrag)
		set("n", "<c-leftrelease>", mc.handleMouseRelease)

		-- Disable and enable cursors.
		set({ "n", "x" }, "<c-q>", mc.toggleCursor, { desc = "Toggle cursors" })

		-- Mappings defined in a keymap layer only apply when there are
		-- multiple cursors. This lets you have overlapping mappings.
		mc.addKeymapLayer(function(layerSet)
			-- Select a different cursor as the main one.
			layerSet({ "n", "x" }, "<left>", mc.prevCursor, { desc = "Select previous cursor" })
			layerSet({ "n", "x" }, "<right>", mc.nextCursor, { desc = "Select next cursor" })

			-- Delete the main cursor.
			layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor, { desc = "Delete main cursor" })

			-- Enable and clear cursors using escape.
			layerSet("n", "<esc>", function()
				if not mc.cursorsEnabled() then
					mc.enableCursors()
				else
					mc.clearCursors()
				end
			end, { desc = "Enable or clear cursors" })
		end)

		-- Customize how cursors look.
		local hl = vim.api.nvim_set_hl
		hl(0, "MultiCursorCursor", { reverse = true })
		hl(0, "MultiCursorVisual", { link = "Visual" })
		hl(0, "MultiCursorSign", { link = "SignColumn" })
		hl(0, "MultiCursorMatchPreview", { link = "Search" })
		hl(0, "MultiCursorDisabledCursor", { reverse = true })
		hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
		hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
	end,
	event = { "BufEnter" },
}
