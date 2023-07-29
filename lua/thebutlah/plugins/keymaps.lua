-- This file is for plugin-specific keymaps. I could have colocated these in the
-- actual plugin specs, but decided to put them all in one file to make it clear
-- what keymaps are present and see everything in one spot.
--
-- This works because lazy.nvim will merge all plugin specs together.

-- Helper function to avoid eagerly loading telescope
local tscb = function(attr)
	-- https://stackoverflow.com/a/69082950
	return function()
		require('telescope.builtin')[attr]()
	end
end

return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		keys = { { "<leader>x", ":Neotree<CR>", desc = "File E[x]plorer" } }
	},

	-- "gc" to comment visual regions/lines
	{ 'numToStr/Comment.nvim', opts = {}, event = 'BufReadPost' },

	{
		'nvim-telescope/telescope.nvim',
		keys = {
			{ '<leader>?',       tscb('oldfiles'), desc = '[?] Find recently opened files' },
			{ '<leader><space>', tscb('buffers'),  desc = '[ ] Find existing buffers' },
			{
				'<leader>/',
				function()
					-- You can pass additional configuration to telescope to change theme, layout, etc.
					require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
						winblend = 10,
						previewer = false,
					})
				end,
				desc = '[/] Fuzzily search in current buffer'
			},
			{ '<leader>gf', tscb('git_files'),   desc = 'Search [G]it [F]iles' },
			{ '<leader>sf', tscb('find_files'),  desc = '[S]earch [F]iles' },
			{ '<leader>sh', tscb('help_tags'),   desc = '[S]earch [H]elp' },
			{ '<leader>sw', tscb('grep_string'), desc = '[S]earch current [W]ord' },
			{ '<leader>sg', tscb('live_grep'),   desc = '[S]earch by [G]rep' },
			{ '<leader>sd', tscb('diagnostics'), desc = '[S]earch [D]iagnostics' },
		},
	},

	{
		'nvim-treesitter/nvim-treesitter',
		opts = {
			textobjects = {
				select = {
					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						['aa'] = '@parameter.outer',
						['ia'] = '@parameter.inner',
						['af'] = '@function.outer',
						['if'] = '@function.inner',
						['ac'] = '@class.outer',
						['ic'] = '@class.inner',
					}
				}
			},
			move = {
				goto_next_start = {
					[']m'] = '@function.outer',
					[']]'] = '@class.outer',
				},
				goto_next_end = {
					[']M'] = '@function.outer',
					[']['] = '@class.outer',
				},
				goto_previous_start = {
					['[m'] = '@function.outer',
					['[['] = '@class.outer',
				},
				goto_previous_end = {
					['[M'] = '@function.outer',
					['[]'] = '@class.outer',
				},
			},
			swap = {
				swap_next = {
					['<leader>a'] = '@parameter.inner',
				},
				swap_previous = {
					['<leader>A'] = '@parameter.inner',
				},
			},
		}
	},
	{
		'hrsh7th/nvim-cmp',
		opts = {
			mapping = function(cmp)
				local luasnip = require('luasnip')
				return cmp.mapping.preset.insert {
					['<C-n>'] = cmp.mapping.select_next_item(),
					['<C-p>'] = cmp.mapping.select_prev_item(),
					['<C-d>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete {},
					['<CR>'] = cmp.mapping.confirm {
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					},
					['<Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { 'i', 's' }),
					['<S-Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { 'i', 's' }),
				}
			end
		}
	}
}
