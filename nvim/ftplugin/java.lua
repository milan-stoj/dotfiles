-- JDTLS (Java LSP) configuration
local home = vim.env.HOME -- Get the home directory
local jdtls = require 'jdtls'
local capabilities = vim.lsp.protocol.make_client_capabilities()
local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = home .. '/jdtls-workspace/' .. project_name

local system_os = ''

-- Determine OS
if vim.fn.has 'mac' == 1 then
  system_os = 'mac'
elseif vim.fn.has 'unix' == 1 then
  system_os = 'linux'
elseif vim.fn.has 'win32' == 1 or vim.fn.has 'win64' == 1 then
  system_os = 'win'
else
  print "OS not found, defaulting to 'linux'"
  system_os = 'linux'
end

-- Needed for debugging
local bundles = {
  vim.fn.glob(home .. '/.local/share/nvim/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar'),
}

local extra_bundles = vim.fn.glob(home .. '/source/vscode-java-test/server/*.jar', true, true, true)

-- Needed for running/debugging unit tests
vim.list_extend(bundles, extra_bundles)

vim.bo.tabstop = 2
vim.bo.shiftwidth = 2
vim.bo.expandtab = true
vim.bo.autoindent = true
vim.bo.smartindent = true

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-javaagent:' .. home .. '/.local/share/nvim/mason/share/jdtls/lombok.jar',
    '-Xmx4g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',

    -- Eclipse jdtls location
    '-jar',
    home .. '/.local/share/nvim/mason/share/jdtls/plugins/org.eclipse.equinox.launcher.jar',
    '-configuration',
    home .. '/.local/share/nvim/mason/packages/jdtls/config_' .. system_os,
    '-data',
    workspace_dir,
  },

  -- 💀
  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  --
  -- vim.fs.root requires Neovim 0.10.
  -- If you're using an earlier version, use: require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
  root_dir = vim.fs.root(0, { '.git', 'mvnw', 'gradlew' }),

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
      signatureHelp = { enabled = true },
      referencesCodeLens = { enabled = true },
      references = { includeDecompiledSources = true },
      inlayHints = {
        enabled = 'all',
      },
      format = {
        enabled = true,
        settings = {
          url = '/Users/nfc7148/code-style/java/default.xml',
        },
      },
      completion = {},
      sources = {},
      extendedClientCapabilities = jdtls.extendedClientCapabilities,
    },
  },

  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  -- Needed for auto-completion with method signatures and placeholders
  capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities()),

  flags = {
    allow_incremental_sync = true,
  },

  init_options = {
    -- References the bundles defined above to support Debugging and Unit Testing
    bundles = bundles,
  },
  handlers = {
    ['language/status'] = function(_, result)
      -- Print or whatever.
    end,
    ['$/progress'] = function(_, result, ctx)
      -- disable progress updates.
    end,
  },
}

-- Needed for debugging
config['on_attach'] = function(client, bufnr)
  jdtls.setup_dap { hotcodereplace = 'auto' }
  require('jdtls.dap').setup_dap_main_class_configs()
end

-- This starts a new client & server, or attaches to an existing client & server based on the `root_dir`.
require('jdtls').start_or_attach(config)
