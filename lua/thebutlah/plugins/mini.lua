return {
	"echasnovski/mini.nvim",
	version = "^0.14",
	config = function()
		-- Better Around/Inside textobjects
		--
		-- Examples:
		--  - va)  - [V]isually select [A]round [)]paren
		--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
		--  - ci'  - [C]hange [I]nside [']quote
		require("mini.ai").setup({ n_lines = 500 })

		-- Add/delete/replace surroundings (brackets, quotes, etc.)
		--
		-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
		-- - sd'   - [S]urround [D]elete [']quotes
		-- - sr)'  - [S]urround [R]eplace [)] [']
		require("mini.surround").setup()

		-- Automatically insert matching pairs for quotes, braces, etc
		-- require("mini.pairs").setup()

		-- Animation to show the current indent scope
		-- require("mini.indentscope").setup({
		-- 	symbol = vim.g.have_nerd_font and "╎" or "╎",
		-- })

		-- ... and there is more!
		--  Check out: https://github.com/echasnovski/mini.nvim
	end,
}
