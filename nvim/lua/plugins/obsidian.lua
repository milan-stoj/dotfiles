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

    notes_subdir = '100-inbox',

    new_notes_location = 'notes-subdir',

    daily_notes = {
      folder = '000-daily',
      default_tags = { 'daily' },
      template = 'daily',
    },

    -- Optional, customize how note IDs are generated given an optional title.
    ---@param title string|?
    ---@return string
    note_id_func = function(title)
      -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
      -- In this case a note with the title 'My new note' will be given an ID that looks
      -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
      local suffix = ''
      if title ~= nil then
        -- If title is given, transform it into valid file name.
        suffix = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
      else
        -- If title is nil, just add 4 random uppercase letters to the suffix.
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      local t = os.date '*t'
      local timestamp = string.format('%04d-%02d-%02d-%02d%02d', t.year, t.month, t.day, t.hour, t.min)
      return timestamp .. '-' .. suffix
    end,
  },
}
