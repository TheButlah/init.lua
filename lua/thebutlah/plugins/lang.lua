-- Language specific configuration
return {
	'neovim/nvim-lspconfig',
	dependencies = {
		-- Additional lua configuration, makes nvim stuff amazing!
		{ 'folke/neodev.nvim', opts = {} }
	}
}
