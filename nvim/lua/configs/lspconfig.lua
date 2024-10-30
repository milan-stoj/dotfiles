-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls", "marksman" }
local nvlsp = require "nvchad.configs.lspconfig"
local java_path = vim.fn.getenv "JAVA_HOME"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- configuring single server, example: typescript
lspconfig.jdtls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  cmd = {
    java_path,
    "-Dcom.sun.net.ssl.checkRevocation=false",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-jar",
    "/path/to/jdtls/plugins/org.eclipse.equinox.launcher_VERSION.jar",
    "-configuration",
    "/path/to/jdtls/config_SYSTEM",
    "-data",
    "/path/to/jdtls/workspace",
  },
}

vim.cmd [[
  autocmd FileType java setlocal tabstop=4
  autocmd FileType java setlocal shiftwidth=4
  autocmd FileType java setlocal expandtab
]]
