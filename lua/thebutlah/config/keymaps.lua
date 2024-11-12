-- Note: Plugin-specific keymaps live next to their plugin specs, because they
-- are used by lazy.nvim to lazily load plugins and must be a part of that
-- plugin's spec.
--
-- This file only contains general plugin-agnostic keymaps.

-- Auto-center on ctrl-u, ctrl-d
vim.keymap.set({ "n", "v" }, "<C-d>", "<C-d>zz")
vim.keymap.set({ "n", "v" }, "<C-u>", "<C-u>zz")

-- Diagnostic keymaps
vim.keymap.set(
	"n",
	"<leader>e",
	vim.diagnostic.open_float,
	{ desc = "Open floating diagnostic message" }
)
vim.keymap.set(
	"n",
	"<leader>q",
	vim.diagnostic.setloclist,
	{ desc = "Open diagnostics list" }
)

vim.keymap.set({ "n", "v" }, "<leader>tl", function(...)
	local listchars = vim.opt.listchars:get()
	if listchars.tab == "  " then
		listchars.tab = "» "
	else
		listchars.tab = "  "
	end
	vim.opt.listchars = listchars
end, { desc = "[T]oggle [L]istchars" })
