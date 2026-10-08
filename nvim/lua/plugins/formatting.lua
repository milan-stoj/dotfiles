local conform = require 'conform'
conform.setup {
  default_format_opts = { lsp_format = 'fallback' },
  formatters_by_ft = {
    lua = { 'stylua' },
    javascript = { 'prettierd', 'eslint_d' },
    javascriptreact = { 'prettierd', 'eslint_d' },
    markdown = { 'prettier_markdown' },
    typescript = { 'prettierd', 'prettier', stop_after_first = true },
    typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
    json = { 'prettierd', 'prettier', stop_after_first = true },
    yaml = { 'prettierd', 'prettier', stop_after_first = true },
    cs = { 'csharpier' }, -- optional: install CSharpier if your team uses it
    sh = { 'shfmt' },
    zsh = { 'shfmt' },
    -- Intentionally no markdown: preserve Obsidian spacing, callouts, and frontmatter.
  },
  -- format_on_save = { timeout_ms = 1500, lsp_format = 'fallback' },
  formatters = {
    prettierd = {
      prepend_args = { '--print-width=120', '--single-quote' },
    },
    prettier_markdown = {
      inherit = 'prettier',
      prepend_args = {
        '--prose-wrap',
        'preserve',
        '--embedded-language-formatting',
        'off',
      },
    },
  },
}
vim.keymap.set({ 'n', 'x' }, '<leader>cf', function()
  conform.format { async = true }
end, { desc = 'Format' })
