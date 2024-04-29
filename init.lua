-- Standard boilerplate to install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.notify("Installing lazy package manager...")
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
	local f = io.open(vim.fn.stdpath("config") .. "/lazy-lock.json", "r")
	if f then
		local data = f:read("*a")
		local lock = vim.json.decode(data)
		vim.fn.system { "git", "-C", lazypath, "checkout", lock["lazy.nvim"].commit }
	end
end
vim.opt.rtp:prepend(lazypath)

-- Set `mapleader` before lazy so mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Will merge all plugins in `lua/plugins/*.lua` into the main plugin spec.
require("lazy").setup("thebutlah/plugins", {
	defaults = { lazy = true },
	install = { colorscheme = { "onedark" } },
})

-- Each of these lua modules will be run, for non-plugin configuration.
require("thebutlah.config.options")
require("thebutlah.config.keymaps")
require("thebutlah.config.autocmds")
