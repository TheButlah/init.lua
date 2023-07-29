return {
	{
		-- Helper plugin to set configure lsp, autocompletion, etc
		'VonHeikemen/lsp-zero.nvim',
		branch = 'dev-v3',
		lazy = true,
		config = false,
	},

	{
		-- Mason manages installation of third party programs like language servers
		'williamboman/mason.nvim',
		cmd = { 'Mason', 'MasonInstall', 'MasonUpdate' },
		lazy = true,
		config = true,
	},

	{
		-- Autocompletion Framework
		'hrsh7th/nvim-cmp',
		event = 'InsertEnter',
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',
			-- Adds a number of user-friendly snippets
			'rafamadriz/friendly-snippets',
		},
		opts = {
			snippet = {
				expand = function(args)
					require('luasnip').lsp_expand(args.body)
				end,
			},
			sources = {
				{ name = 'nvim_lsp' },
				{ name = 'luasnip' },
			},
		},
		config = function(_, opts)
			-- Here is where you configure the autocompletion settings.
			require('lsp-zero').extend_cmp()

			-- And you can configure cmp even more, if you want to.
			local cmp = require('cmp')
			local cmp_action = require('lsp-zero').cmp_action()

			opts.mapping = opts.mapping(cmp)
			cmp.setup(opts)
		end
	},

	{
		-- Configuration for the LSPs
		'williamboman/mason-lspconfig.nvim',
		cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
		event = { 'BufReadPre', 'BufNewFile' },
		dependencies = {
			{ 'neovim/nvim-lspconfig' },
			{ 'hrsh7th/cmp-nvim-lsp' },
		},
		config = function()
			-- This is where all the LSP shenanigans live

			local lsp = require('lsp-zero').preset({})

			lsp.on_attach(function(client, bufnr)
				lsp.default_keymaps({ buffer = bufnr })
			end)

			require('mason-lspconfig').setup({
				ensure_installed = { 'lua_ls', 'rust_analyzer' },
				handlers = {
					lsp.default_setup,
					lua_ls = function()
						-- (Optional) Configure lua language server for neovim
						require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
					end,
				}
			})
		end
	}
}
