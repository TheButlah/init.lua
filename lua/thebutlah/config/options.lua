-- Controls general neovim settings. For more info, run `:help <settingname>`

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

-- Make relative line numbers default
vim.wo.relativenumber = true
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard with OS
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive search unless uppercase
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
-- Note: Also needed by which-key, but seems generally useful.
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Note: Make sure your terminal supports this
vim.o.termguicolors = true

-- Prevent cursor from reaching any closer than this number of lines to the edge
vim.opt.scrolloff = 4
