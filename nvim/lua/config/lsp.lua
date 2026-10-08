vim.lsp.config('*', {
  capabilities = require('blink.cmp').get_lsp_capabilities(),
})

vim.diagnostic.config {
  severity_sort = true,
  update_in_insert = false,
  underline = true,
  virtual_text = { spacing = 2, source = 'if_many' },
  float = { border = 'rounded', source = 'if_many' },
}

require('mason').setup {}

-- C# is handled by roslyn.nvim, so it is deliberately not in this list.
local servers = { 'lua_ls', 'ts_ls', 'jsonls', 'yamlls', 'bashls' }
require('mason-lspconfig').setup {
  ensure_installed = servers,
  automatic_enable = false,
}
require('mason-tool-installer').setup {
  ensure_installed = { 'stylua', 'prettierd', 'eslint_d', 'shellcheck', 'shfmt' },
}
for _, server in ipairs(servers) do
  vim.lsp.enable(server)
end

-- One C# server: Roslyn. Install its executable with :MasonInstall roslyn-language-server.
require('roslyn').setup {}

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('user-lsp-attach', { clear = true }),
  callback = function(event)
    local function map(lhs, rhs, desc)
      vim.keymap.set('n', lhs, rhs, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    map('gd', function()
      require('snacks').picker.lsp_definitions()
    end, 'Go to definition')

    map('gD', function()
      require('snacks').picker.lsp_declarations()
    end, 'Go to declaration')

    map('gr', function()
      require('snacks').picker.lsp_references()
    end, 'Go to references')

    map('gi', function()
      require('snacks').picker.lsp_implementations()
    end, 'Go to implementation')
    map('K', vim.lsp.buf.hover, 'Hover')
    map('<leader>rn', vim.lsp.buf.rename, 'Rename')
    map('<leader>ca', vim.lsp.buf.code_action, 'Code action')
    map('<leader>e', vim.diagnostic.open_float, 'Line diagnostics')
    map('<leader>f', vim.lsp.buf.format, 'Format Buffer')
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method('textDocument/inlayHint', event.buf) then
      map('<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }, { bufnr = event.buf })
      end, 'Toggle inlay hints')
    end
  end,
})
