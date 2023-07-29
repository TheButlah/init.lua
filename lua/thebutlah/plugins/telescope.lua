-- Telescope is a high performance fuzzy finder for text, files, and more.

return {
	'nvim-telescope/telescope.nvim',
	branch = '0.1.x',
	cmd = { 'Telescope' },
	dependencies = {
		'nvim-lua/plenary.nvim',
		-- TODO: Should this be a dependent or a separate thing entirely?
		{
			'nvim-telescope/telescope-fzf-native.nvim',
			-- NOTE: If you are having trouble with this installation,
			--       refer to the README for telescope-fzf-native for more instructions.
			build = 'make',
			cond = function()
				return vim.fn.executable 'make' == 1
			end,
		},
	},
	opts = {
		defaults = {
			mappings = {
				i = {
					['<C-u>'] = false,
					['<C-d>'] = false,
				},
			},
		},
		pickers = {
			find_files = {
				find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
			},
		},
	},
	config = function(_, opts)
		require('telescope').setup(opts)
		-- Enable telescope fzf native, if installed
		pcall(require('telescope').load_extension, 'fzf')
	end

}
