return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = true,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true, java = true, javascript = true }
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {
          timeout_ms = 500,
          lsp_format = 'fallback',
        }
      end
    end,
    formatters_by_ft = {
      -- markdown = { 'markdownlint-cli2' },
      lua = { 'stylua' },
      html = { 'prettier' },
      python = { 'isort', 'black' },
      java = { 'nvim-jdlts' },
      --
      -- You can use 'stop_after_first' to run the first available formatter from the list
      javascript = { 'prettier' },
      json = { 'prettier' },
    },
  },
}
