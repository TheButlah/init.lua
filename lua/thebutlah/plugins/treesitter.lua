return {
	-- Highlight, edit, and navigate code
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	lazy = "false",
	init = function()
		local parsers = {
			"bash",
			"c",
			"diff",
			"html",
			"json",
			"lua",
			"luadoc",
			"markdown",
			"markdown_inline",
			"query",
			"rust",
			"toml",
			"vim",
			"vimdoc",
			"yaml",
		}
		require("nvim-treesitter").install(parsers)
		for _, p in pairs(parsers) do
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { p },
				callback = function()
					vim.treesitter.start()
				end,
			})
		end
	end,
	dependencies = {
		-- Adds ability to navigate with treesitter textobjects
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
			branch = "main",
			init = function()
				-- Disable entire built-in ftplugin mappings to avoid conflicts.
				-- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
				vim.g.no_plugin_maps = true
			end,
			opts = {
				select = {
					enable = true,
					lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
				},
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
				},
				swap = {
					enable = false,
				},
			},
		},
		{ "nvim-treesitter/nvim-treesitter-context", opts = {
			max_lines = 2,
		} },
	},
}
