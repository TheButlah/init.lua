-- Controls general neovim settings. For more info, run `:help <settingname>`

-- NOTE: `mapleader` should be set before lazy.nvim so mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
-- This isn't a vim builtin, its specific to our config
vim.g.have_nerd_font = true
-- Note: Make sure your terminal supports this
vim.o.termguicolors = true
-- Enable mouse mode
vim.o.mouse = "a"
-- Sync clipboard between OS and Neovim. Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
	vim.opt.clipboard:append({ "unnamed", "unnamedplus" })
	-- https://github.com/neovim/neovim/discussions/28010#discussioncomment-9877494
	local function paste()
		return {
			vim.fn.split(vim.fn.getreg(""), "\n"),
			vim.fn.getregtype(""),
		}
	end
	vim.g.clipboard = {
		name = "OSC 52",
		copy = {
			["+"] = require("vim.ui.clipboard.osc52").copy("+"),
			["*"] = require("vim.ui.clipboard.osc52").copy("*"),
		},
		paste = {
			["+"] = paste,
			["*"] = paste,
		},
	}
end)

-- Prefer tabs, render as 4 spaces
vim.o.tabstop = 4
vim.o.softtabstop = 0
vim.o.shiftwidth = 0
vim.o.expandtab = false

-- Display column rulers
vim.o.colorcolumn = "80,88,100"

-- Don't highlight after completing a search, but show it while typing it.
vim.o.hlsearch = false
vim.o.incsearch = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Make relative line numbers default
vim.wo.relativenumber = true
vim.wo.number = true

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive search unless uppercase
vim.o.ignorecase = true
vim.o.smartcase = true

-- Reserve a space in the gutter
-- This will avoid an annoying layout shift in the screen
vim.wo.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250
-- Note: Also needed by which-key, but seems generally useful.
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- Prevent cursor from reaching any closer than this number of lines to the edge
vim.opt.scrolloff = 4

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }

-- Don't show the mode, since it's already in the status line
-- vim.opt.showmode = false

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- vim.diagnostic.config({ virtual_lines = true })
vim.diagnostic.config({
	virtual_lines = {
		-- Only show virtual line diagnostics for the current cursor line
		current_line = true,
	},
})
