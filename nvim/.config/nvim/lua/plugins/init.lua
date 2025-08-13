return {
	{
		"stevearc/conform.nvim",
		-- event = 'BufWritePre', -- uncomment for format on save
		opts = require("configs.conform"),
	},

	{
		"folke/which-key.nvim",
		lazy = false,
	},

	-- nvim-tree
	{
		"nvim-tree/nvim-tree.lua",
		opts = require("configs.nvim-tree"),
	},

	-- These are some examples, uncomment them if you want to see them work!
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("nvchad.configs.lspconfig").defaults()
			require("configs.lspconfig")
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-lspconfig" },
		config = function()
			require("mason-lspconfig").setup()
		end,
	},

	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("configs.lint")
		end,
	},

	--[[ Mason
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
				"json-lsp",

				-- cpp
				"clangd",

				-- rust
				"rust-analyzer",
				"taplo",

				-- python
				"pyright",

				-- general
				"codelldb",
			},
			automatic_installation = true,
		},
	}, --]]
	{
		"zapling/mason-conform.nvim",
		event = "VeryLazy",
		dependencies = { "conform.nvim" },
		config = function()
			require("configs.mason-conform")
		end,
	},
	{
		"rshkarin/mason-nvim-lint",
		event = "VeryLazy",
		dependencies = { "nvim-lint" },
		config = function()
			require("configs.mason-lint")
		end,
	},
	-- fish
	{
		"ndonfris/fish-lsp",
		ft = "fish",
		dependencies = "neovim/nvim-lspconfig",
	},

	-- Tree sitter
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("configs.treesitter")
		end,
	},

	-- Copilot
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("configs.copilot")
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		cmd = "CopilotChat",
		dependencies = {
			{ "zbirenbaum/copilot.lua" },
			{ "nvim-lua/plenary.nvim", branch = "master" },
		},
		build = "make tiktoken",
		opts = require("configs.copilotchat"),
		-- lazy = false,
	},

	--JSONc
	{
		"neoclide/jsonc.vim",
		ft = "jsonc",
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
		lazy = false,
		config = function()
			require("configs.rustaceanvim")
		end,
	},

	{
		"saecki/crates.nvim",
		ft = { "toml" },
		config = function()
			-- NvChad said that `completion.cmp.enabled` is deprecated
			-- the nvim-cmp source will be removed soon. Use the in-process language server instead.
			--[[ require("crates").setup({
				completion = {
					cmp = {
						enabled = true,
					},
				},
			})--]]
			require("cmp").setup.buffer({
				sources = { { name = "crates" } },
			})
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		opts = function(_, opts)
			table.insert(opts.sources, { name = "crates" })
		end,
	},

	-- vim tmux navigator
	-- for seamlessly navigate between vim and tmux panes
	{
		"christoomey/vim-tmux-navigator",
		lazy = false, -- always load this plugin
	},

	-- debug adapter protocol
	{
		"mfussenegger/nvim-dap",
		config = function()
			require("configs.nvim-dap")
		end,
	},

	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = function()
			require("dapui").setup()
		end,
	},

	-- trouble
	{
		"folke/trouble.nvim",
		opts = {},
		cmd = "Trouble",
		keys = require("configs.trouble").keys,
	},
}
