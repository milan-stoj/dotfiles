vim.lsp.enable 'lua_ls'
vim.lsp.enable 'clangd_ls'
vim.lsp.enable 'html'

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('native-lsp-attach', { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client ~= nil and client:supports_method 'textDocument/completion' then
      local chars = {}
      for i = 32, 126 do
        table.insert(chars, string.char(i))
      end
      client.server_capabilities.completionProvider.triggerCharacters = chars
      vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }
      vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
      -- vim.keymap.set('i', '<C-Space>', function()
      --   vim.lsp.completion.get()
      -- end)
    end
    local buf = event.buf
    local map = function(lhs, rhs, desc)
      vim.keymap.set('n', lhs, rhs, { buffer = buf, desc = desc })
    end

    map('gd', vim.lsp.buf.definition, 'Go to definition')
    map('gD', vim.lsp.buf.declaration, 'Go to declaration')
    map('gr', vim.lsp.buf.references, 'Go to references')
    map('gi', vim.lsp.buf.implementation, 'Go to implementation')
    map('K', vim.lsp.buf.hover, 'Hover')
    map('<leader>rn', vim.lsp.buf.rename, 'Rename')
    map('<leader>ca', vim.lsp.buf.code_action, 'Code action')
    map('<leader>e', vim.diagnostic.open_float, 'Line diagnostics')
    map('[d', vim.diagnostic.goto_prev, 'Prev diagnostic')
    map(']d', vim.diagnostic.goto_next, 'Next diagnostic')
    map('<leader>f', vim.lsp.buf.format, 'Format Buffer')
  end,
})

vim.diagnostic.config {
  severity_sort = true,
  underline = true,
  update_in_insert = false,
  float = {
    border = 'rounded',
    source = 'if_many',
  },
}
