return {
  'obsidian-nvim/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = true,
  -- ft = 'markdown',
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  event = {
    -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    'BufReadPre '
      .. vim.fn.expand '~'
      .. '/Obsidian/pkm-vault/*.md',
    'BufNewFile ' .. vim.fn.expand '~' .. '/Obsidian/pkm-vault/*.md',
  },
  dependencies = {
    -- Required.
    'nvim-lua/plenary.nvim',
  },
  opts = {
    workspaces = {
      {
        name = 'work',
        path = '~/Obsidian/pkm-vault',
      },
    },

    completion = {
      blink = true,
      min_chars = 2,
    },

    ui = {
      enable = false,
    },

    templates = {
      folder = 'templates',
    },

    new_notes_location = '100-inbox',

    daily_notes = {
      folder = '000-daily',
      default_tags = { 'daily' },
    },
  },
}
