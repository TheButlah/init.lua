return { -- Helpful popup to explain keybindings
	"folke/which-key.nvim",
	version = "^3",
	event = "VeryLazy",
	opts = {
		spec = {
			{ "<leader>a", group = "[A]I" },
			{ "<leader>ac", group = "avante: [C]onflict" },
			{ "<leader>c", group = "[C]ode", mode = { "n", "x" } },
			{ "<leader>d", group = "[D]ocument" },
			{ "<leader>r", group = "[R]ename" },
			{ "<leader>s", group = "[S]earch" },
			{ "<leader>t", group = "[T]oggle" },
			{ "<leader>w", group = "[W]orkspace" },
			{ "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
