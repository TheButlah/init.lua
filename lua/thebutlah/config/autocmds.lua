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

-- Function to print merged plugin spec
local function print_plugin_spec()
	-- Get the lazy.nvim module
	local lazy = require("lazy")
	local inspect = require("vim.inspect")

	-- Get all plugins
	local plugins = lazy.plugins()

	-- Create a temporary buffer
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
	vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
	vim.api.nvim_buf_set_option(buf, "swapfile", false)

	-- Format each plugin's spec
	local all_lines = {}
	for _, plugin in pairs(plugins) do
		table.insert(all_lines, string.format("--- Plugin: %s ---", plugin.name))
		-- Convert the plugin table to a string representation
		local plugin_str = inspect(plugin)
		-- Split the string into lines and add them
		for line in plugin_str:gmatch("[^\r\n]+") do
			table.insert(all_lines, line)
		end
		table.insert(all_lines, "")
	end

	-- Set the buffer content all at once
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, all_lines)

	-- Open the buffer in a new window
	vim.cmd("vsplit")
	local win = vim.api.nvim_get_current_win()
	vim.api.nvim_win_set_buf(win, buf)

	-- Set buffer name
	vim.api.nvim_buf_set_name(buf, "Lazy Plugin Spec")

	-- Optional: Set syntax highlighting
	vim.cmd("set ft=lua")

	-- Make buffer read-only
	vim.api.nvim_buf_set_option(buf, "modifiable", false)
end

-- Create a user command to call the function
vim.api.nvim_create_user_command("PrintLazySpec", print_plugin_spec, {})
