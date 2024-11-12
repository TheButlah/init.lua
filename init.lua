-- Standard boilerplate to install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		lazyrepo,
		lazypath,
	})
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
	local f = io.open(vim.fn.stdpath("config") .. "/lazy-lock.json", "r")
	if f then
		local data = f:read("*a")
		local lock = vim.json.decode(data)
		vim.fn.system({ "git", "-C", lazypath, "checkout", lock["lazy.nvim"].commit })
	end
end
vim.opt.rtp:prepend(lazypath)

-- Each of these lua modules will be run, for non-plugin configuration.
require("thebutlah.config.options")
require("thebutlah.config.keymaps")
require("thebutlah.config.autocmds")

-- Will merge all plugins in `thebutlah/plugins/*.lua` into the main plugin spec.
require("lazy").setup({
	spec = { import = "thebutlah/plugins" },
	-- spec = {},
	defaults = { lazy = true },
	install = { colorscheme = { "tokyonight-night" } },
})
