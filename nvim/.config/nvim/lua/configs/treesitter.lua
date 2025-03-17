local options = {
	ensure_installed = {
		-- defaults
		"vim",
		"lua",
		"luadoc",
		"vimdoc",
		"html",
		"css",

		-- rust
		"rust",
		"toml",
		"yaml",

		-- work
		"bash",
		"fish",
		"haskell",
		"java",
		"javascript",
		"kotlin",
		"markdown",
		"printf",
		"python",
		"tsx",
		"typescript",

		-- low level
		"c",
		"cpp",
	},

	highlight = {
		enable = true,
		use_languagetree = true,
	},

	indent = { enable = true },
}

require("nvim-treesitter.configs").setup(options)
