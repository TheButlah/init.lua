-- Treesitter is a high performance parser that can understand the syntax of code
-- much faster than a LSP can.

return {
	-- Adds highlighting and the framework necessary to operate on syntax
	'nvim-treesitter/nvim-treesitter',
	event = "BufReadPost",
	dependencies = {
		-- Adds ability to navigate with treesitter textobjects
		{ 'nvim-treesitter/nvim-treesitter-textobjects' },
		{ 'nvim-treesitter/nvim-treesitter-context',    opts = {} }
	},
	build = ':TSUpdate',
	opts = {
		-- Add languages to be installed here that you want installed for treesitter
		ensure_installed = {
			'c',
			'cpp',
			'go',
			'json',
			'lua',
			'python',
			'rust',
			'toml',
			'tsx',
			'typescript',
			'vim',
			'vimdoc',
			'yaml',
		},

		-- Autoinstall languages that are not installed.
		auto_install = true,

		highlight = { enable = true },
		indent = { enable = true },
		incremental_selection = {
			enable = false,
		},
		textobjects = {
			select = {
				enable = true,
				lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
			},
			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
			},
			swap = {
				enable = true,
			},
		},
	},
	config = function(_, opts)
		require('nvim-treesitter.configs').setup(opts)
	end
}
