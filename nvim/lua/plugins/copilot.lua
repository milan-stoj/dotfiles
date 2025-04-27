return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  config = function()
    require('copilot').setup {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = '<Tab>',
          next = '<M-]>', -- Alt + ] to go to the next suggestion
          prev = '<M-[>', -- Alt + [ to go to the previous suggestion
          dismiss = '<C-]>', -- Ctrl + ] to dismiss the suggestion
        },
      },
      panel = {
        enabled = true,
        auto_refresh = true,
        keymap = {
          jump_prev = '[[',
          jump_next = ']]',
          accept = '<CR>',
          refresh = 'gr',
          open = '<M-CR>',
        },
      },
      filetypes = {
        lua = true,
        java = true,
        yaml = false,
        markdown = true,
        help = false,
        html = true,
        css = true,
        javascript = true,
        -- Add more filetypes as needed
      },
    }
  end,
}
