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
		opts = {
			filters = {
				dotfiles = false,
			},
			git = {
				enable = true,
				ignore = false,
				timeout = 500,
			},
		},
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
			require("copilot").setup({
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
			})
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
		opts = {
			-- the key mapping will mess up with other plugins
			-- check [here](https://github.com/CopilotC-Nvim/CopilotChat.nvim/issues/986)

			prompts = {
				ExplainZh = {
					prompt = "为所选代码撰写解释说明，采用段落形式的文本描述.",
					system_prompt = "COPILOT_EXPLAIN",
				},
				ReviewZh = {
					prompt = "审查所选代码",
					system_prompt = "COPILOT_REVIEW",
				},
				FixZh = {
					prompt = "这段代码存在问题，找出问题所在，并在修复的基础上重写代码。解释出错的地方以及你的修改是如何解决这些问题的。",
				},
				OptimizeZh = {
					prompt = "优化所选代码以提升性能和可读性。解释你的优化策略以及你所做更改的好处。",
				},
				DocsZh = {
					prompt = "为所选代码添加文档注释。",
				},
				Tests = {
					prompt = "请为我的代码生成测试用例。",
				},
				Commit = {
					prompt = "请按照 commitizen 规范为该更改编写提交信息。请确保标题不超过 50 个字符，并在 72 个字符处换行格式化，格式采用 gitcommit 代码块",
					context = "git:staged",
				},
			},
		},
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
			-- debug setup
			local mason_registry = require("mason-registry")
			local codelldb = mason_registry.get_package("codelldb")
			local extension_path = codelldb:get_install_path() .. "/extension/"
			local codelldb_path = extension_path .. "adapter/codelldb"
			local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

			if vim.loop.os_uname().sysname == "Darwin" then
				liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
			end

			local cfg = require("rustaceanvim.config")

			vim.g.rustaceanvim = {
				dap = {
					adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
				},
				tools = {
					float_win_config = {
						border = "rounded",
						auto_focus = true,
						open_split = "horizontal",
					},
				},
			}

			-- require("configs.rustaceanvim")
		end,
	},

	{
		"saecki/crates.nvim",
		ft = { "toml" },
		config = function()
			require("crates").setup({
				completion = {
					cmp = {
						enabled = true,
					},
				},
			})
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
			local dap, dapui = require("dap"), require("dapui")
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
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
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
}
