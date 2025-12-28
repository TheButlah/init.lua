return {
	"lewis6991/gitsigns.nvim",
	version = "^1.0.2",
	event = "BufEnter",
	opts = vim.g.have_nerd_font and {} or {
		signs = {
			add = { text = "+" },
			change = { text = "~" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
		},
	},
}
