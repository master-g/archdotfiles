local options = {
	suggestion = {
		auto_trigger = true,
		debounce = 100,
		keymap = {
			accept = "<Tab>",
		},
	},
	filetypes = {
		css = true,
		eruby = true,
		go = true,
		html = true,
		javascript = true,
		lua = true,
		php = true,
		ruby = true,
		rust = true,
		typescript = true,
		vue = true,
		["*"] = false,
	},
	server_opts_overrides = {},
}

require("copilot").setup(options)
