return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	version = "^0.0.27",
	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	build = vim.fn.has("win32") ~= 0
			and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource true"
		or "make BUILD_FROM_SOURCE=true",
	---@module 'avante'
	---@type avante.Config
	opts = {
		instructions_file = "AGENTS.md",
		mappings = {
			--- @class AvanteConflictMappings
			diff = {
				ours = "<leader>aco",
				theirs = "<leader>act",
				all_theirs = "<leader>aca",
				both = "<leader>acb",
				cursor = "<leader>acc",
				next = "]x",
				prev = "[x",
			},
		},
		input = {
			provider = "snacks",
			provider_opts = {
				-- Additional snacks.input options
				title = "Avante Input",
				icon = " ",
			},
		},
	},
	-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		--- The below dependencies are optional,
		"echasnovski/mini.pick", -- for file_selector provider mini.pick
		"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
		"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
		"ibhagwan/fzf-lua", -- for file_selector provider fzf
		"stevearc/dressing.nvim", -- for input provider dressing
		"folke/snacks.nvim", -- for input provider snacks
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font }, -- or echasnovski/mini.icons
		"zbirenbaum/copilot.lua", -- for providers='copilot'
		{
			-- support for image pasting
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				-- recommended settings
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
					-- required for Windows users
					use_absolute_path = true,
				},
			},
		},
		{
			-- Make sure to set this up properly if you have lazy=true
			"MeanderingProgrammer/render-markdown.nvim",
			enabled = vim.g.have_nerd_font,
			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
		},
	},
}
