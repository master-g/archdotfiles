-- debug setup
local dap_adapter = nil

-- Try to get codelldb path from mason, but don't fail if not available
local ok, mason_registry = pcall(require, "mason-registry")
if ok then
	local codelldb_ok, codelldb = pcall(mason_registry.get_package, "codelldb")
	if codelldb_ok and codelldb:is_installed() then
		local path_ok, install_path = pcall(codelldb.get_install_path)
		if not path_ok then
			vim.notify("codelldb path not found", vim.log.levels.WARN)
			return
		end
		local extension_path = install_path .. "/extension/"
		local codelldb_path = extension_path .. "adapter/codelldb"
		local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

		if vim.loop.os_uname().sysname == "Darwin" then
			liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
		end

		local cfg = require("rustaceanvim.config")
		dap_adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path)
	else
		vim.notify("codelldb not found or not installed via Mason", vim.log.levels.WARN)
	end
else
	vim.notify("mason-registry not found, DAP functionality will be limited", vim.log.levels.WARN)
end

vim.g.rustaceanvim = {
	dap = {
		adapter = dap_adapter,
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
