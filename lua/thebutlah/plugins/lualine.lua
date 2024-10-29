return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		theme = "auto",
		sections = { lualine_c = { { "filename", path = 4 } } },
	},
}
