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

--[[
local nvlsp = require "nvchad.configs.lspconfig"

vim.g.rustaceanvim = {
  server = {
    on_attach = nvlsp.on_attach,
    capabilities = nvlsp.capabilities,
  }
}
--]]
