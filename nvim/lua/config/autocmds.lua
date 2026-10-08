-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Obsidian wiki link navigation
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    -- Forward search for next wiki-link
    vim.keymap.set('n', '<Tab>', function()
      vim.fn.search('\\[\\[.*\\]\\]', 'W')
    end, { buffer = true, desc = 'Next wiki-link' })

    -- Backward search for previous wiki-link
    vim.keymap.set('n', '<S-Tab>', function()
      vim.fn.search('\\[\\[.*\\]\\]', 'bW')
    end, { buffer = true, desc = 'Previous wiki-link' })

    -- go back to previous file
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'markdown',
      callback = function()
        vim.keymap.set('n', '<BS>', '<C-o>', { buffer = true, desc = 'Go back in jump list' })
      end,
    })
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { '<filetype>' },
  callback = function()
    vim.treesitter.start()
  end,
})
