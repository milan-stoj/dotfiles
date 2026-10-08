local ts = require 'nvim-treesitter'
local parsers = {
  'bash',
  'c',
  'lua',
  'luadoc',
  'vim',
  'vimdoc',
  'javascript',
  'typescript',
  'tsx',
  'html',
  'css',
  'json',
  'yaml',
  'c_sharp',
  'markdown',
  'markdown_inline',
  'query',
}
ts.install(parsers)

vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'bash',
    'c',
    'lua',
    'javascript',
    'javascriptreact',
    'typescript',
    'html',
    'css',
    'json',
    'yaml',
    'cs',
    'markdown',
  },

  callback = function()
    vim.treesitter.start()
  end,
})
