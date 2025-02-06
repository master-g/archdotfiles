return {
	{
		"stevearc/conform.nvim",
		-- event = 'BufWritePre', -- uncomment for format on save
		opts = require("configs.conform"),
	},

	-- These are some examples, uncomment them if you want to see them work!
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("configs.lspconfig")
		end,
	},

	-- Mason
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				-- defaults
				"lua-language-server",
				"stylua",

				-- web dev
				"html-lsp",
				"css-lsp",
				"prettier",

				-- rust
				"rust-analyzer",
			},
		},
	},

	-- Tree sitter
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				-- defaults
				"vim",
				"lua",
				"vimdoc",
				"html",
				"css",

				-- rust
				"rust",
				"toml",

				-- work
				"java",
				"javascript",
				"kotlin",
				"python",
				"tsx",
				"typescript",

				-- low level
				"c",
				"cpp",
			},
		},
	},

	-- Copilot
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = {
					auto_trigger = true,
					debounce = 100,
					keymap = {
						accept = "<C-l>",
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
			})
		end,
	},

	-- Rust
	{
		"rust-lang/rust.vim",
		ft = "rust",
		init = function()
			vim.g.rustfmt_autosave = 1
		end,
	},
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    config = function()
      require("configs.rustaceanvim")
    end,
  },

  {
    "saecki/crates.nvim",
    ft = {"rust", "toml"},
    config = function(_, opts)
      local crates = require("crates")
      crates.setup(opts)
      crates.show()
    end
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      table.insert(opts.sources, {name="crates"})
    end,
  }
}
