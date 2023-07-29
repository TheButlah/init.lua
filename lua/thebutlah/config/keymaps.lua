-- Note: Plugin-specific keymaps live in `thebutlah.plugins.keymaps`, because they
-- are used by lazy.nvim to lazily load plugins and must be a part of that plugin's
-- spec.
--
-- This file only contains general plugin-agnostic keymaps.

-- Auto-center on ctrl-u, ctrl-d
vim.keymap.set({ 'n', 'v' }, '<C-d>', '<C-d>zz')
vim.keymap.set({ 'n', 'v' }, '<C-u>', '<C-u>zz')

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })

-- Not entirely sure what this does, but its from kickstart.nvim
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap (also no clue what the use is, but its from kickstart)
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
