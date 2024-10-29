return {
	{ -- Helpful popup to explain keybindings
		"folke/which-key.nvim",
		version = "^1",
		event = "VeryLazy",
		opts = {},
	},

	{ -- Colorscheme
		-- Theme inspired by Atom
		"navarasu/onedark.nvim",
		priority = 1000,
		lazy = false,
		config = function()
			vim.cmd.colorscheme("onedark")
		end,
	},

	{ -- Use a better file tree than the default.
		"nvim-neo-tree/neo-tree.nvim",
		version = "^2",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		lazy = false,
		opts = {
			-- Open to the whole window instead of as a sidebar
			filesystem = { window = { position = "current" } },
		},
		config = function(_, opts)
			-- Removes the deprecated commands from v1.x
			vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
			require("neo-tree").setup(opts)
		end,
	},

	{
		-- A better statusline
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = {
			sections = { lualine_c = { { "filename", path = 4 } } },
		},
	},

	{
		-- Add indentation guides even on blank lines
		"lukas-reineke/indent-blankline.nvim",
		event = "VeryLazy",
		opts = {
			char = "┊",
			show_trailing_blankline_indent = false,
		},
	},

	{
		-- Visually indicates status of LSP
		"neovim/nvim-lspconfig",
		dependencies = { { "j-hui/fidget.nvim", tag = "legacy", opts = {} } },
	},

	-- Git related plugins
	{
		-- Adds git releated signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		event = "BufRead",
		opts = {
			-- See `:help gitsigns.txt`
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			on_attach = function(bufnr)
				vim.keymap.set(
					"n",
					"<leader>gp",
					require("gitsigns").prev_hunk,
					{ buffer = bufnr, desc = "[G]o to [P]revious Hunk" }
				)
				vim.keymap.set(
					"n",
					"<leader>gn",
					require("gitsigns").next_hunk,
					{ buffer = bufnr, desc = "[G]o to [N]ext Hunk" }
				)
				vim.keymap.set(
					"n",
					"<leader>ph",
					require("gitsigns").preview_hunk,
					{ buffer = bufnr, desc = "[P]review [H]unk" }
				)
			end,
		},
	},
	{ "tpope/vim-fugitive", lazy = false, dependencies = "tpope/vim-rhubarb" },
}
