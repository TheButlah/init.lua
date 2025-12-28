return {
	"stevearc/oil.nvim",
	version = "^2.15.0",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {},
	-- Optional dependencies
	dependencies = { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	lazy = false,
	keys = {
		{ "<leader>x", "<cmd>Oil<cr>", desc = "Open parent directory" },
	},
}
