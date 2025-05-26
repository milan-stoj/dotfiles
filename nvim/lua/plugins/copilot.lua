vim.g.copilot_proxy_strict_ssl = false
return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  build = ':Copilot auth',
  event = 'BufReadPost',
  opts = {
    suggestion = {
      enabled = not vim.g.ai_cmp,
      auto_trigger = true,
      hide_during_completion = vim.g.ai_cmp,
      keymap = {
        accept = '<Tab>',
      },
    },
    panel = { enabled = false },
    filetypes = {
      markdown = true,
      help = true,
    },
    copilot_node_command = vim.fn.expand '$HOME' .. '/.nvm/versions/node/v23.6.0/bin/node',
  },
}
