-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

-- EXAMPLE
local servers = { "html", "cssls", "clangd", "pyright", "taplo" }
local nvlsp = require("nvchad.configs.lspconfig")

-- lsps with default config
for _, server in ipairs(servers) do
    vim.lsp.config[server] = {
        on_attach = nvlsp.on_attach,
        on_init = nvlsp.on_init,
        capabilities = nvlsp.capabilities,
    }
end

vim.lsp.config.pyright = {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,

    settings = {
        python = {
            analysis = {
                typeCheckingMode = "off",
            },
        },
    },
}

-- lspconfig.rust_analyzer.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
--   ft = { "rust" },
--   root_dir = lspconfig.util.root_pattern("Cargo.toml", "rust-project.json"),
--   settings = {
--     ["rust-analyzer"] = {
--       assist = {
--         importGranularity = "module",
--         importPrefix = "by_self",
--       },
--       cargo = {
--         allFeatures = true,
--         loadOutDirsFromCheck = true,
--       },
--       procMacro = {
--         enable = true,
--       },
--     },
--   },
-- }

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
