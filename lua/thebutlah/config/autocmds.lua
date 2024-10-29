-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("thebutlah.highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Computes the maximum fold level in the file
local function max_fold_level()
	local last_line = vim.fn.line("$")
	local max_lvl = 0
	for i = 1, last_line do
		max_lvl = math.max(max_lvl, vim.fn.foldlevel(i))
	end
	return max_lvl
end

-- See https://www.jmaguire.tech/posts/treesitter_folding/
local configure_folds = function()
	vim.wo.foldmethod = "expr"
	vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
	vim.wo.foldenable = false -- change to true to auto fold.
	vim.wo.foldminlines = 5
	vim.wo.foldlevel = max_fold_level()
end

local fold_group =
	vim.api.nvim_create_augroup("thebutlah.fold-settings", { clear = true })
vim.api.nvim_create_autocmd("BufWinEnter", {
	group = fold_group,
	pattern = "*",
	callback = configure_folds,
})

-- Set up FormatDisable and FormatEnable user commands
vim.api.nvim_create_user_command("FormatDisable", function(args)
	if args.bang then
		-- FormatDisable! will disable formatting just for this buffer
		vim.b.disable_autoformat = true
	else
		vim.g.disable_autoformat = true
	end
end, {
	desc = "Disable autoformat-on-save",
	bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
	vim.b.disable_autoformat = false
	vim.g.disable_autoformat = false
end, {
	desc = "Re-enable autoformat-on-save",
})
