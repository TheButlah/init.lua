return {
	"vyfor/cord.nvim",
	build = "./build || .\\build",
	event = "VeryLazy",
	opts = {
		display = {
			show_time = true,
		},
		timer = {
			reset_on_idle = true, -- Reset start timestamp on idle
			reset_on_change = false, -- Reset start timestamp on presence change
		},
		idle = {
			enable = true, -- Enable idle status
			show_status = false, -- Display idle status, disable to hide the rich presence on idle
			timeout = 5 * 60 * 1000, -- Timeout in milliseconds after which the idle status is set, 0 to display immediately
			disable_on_focus = false, -- Do not display idle status when neovim is focused
			text = "Idle", -- Text to display when idle
			tooltip = "💤", -- Text to display when hovering over the idle image
		},
	},
}
