require('obsidian').setup {
  legacy_commands = false,
  workspaces = {
    {
      name = 'work',
      path = '~/Obsidian/pkm-vault',
    },
  },

  completion = {
    min_chars = 2,
  },

  templates = {
    folder = 'templates',
  },

  ui = { enable = false },

  notes_subdir = '100-inbox',

  new_notes_location = 'notes_subdir',

  daily_notes = {
    folder = '000-daily',
    default_tags = { 'daily' },
    template = 'daily',
  },

  picker = {
    name = 'snacks.picker',
  },

  cache = { enabled = true },

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
}

local map = vim.keymap.set
map('n', '<leader>oi', '<cmd>edit ~/Obsidian/pkm-vault/Index.md<CR>', { desc = 'Open index' })
map('n', '<leader>odt', '<cmd>Obsidian today<CR>', { desc = "Today's note" })
map('n', '<leader>odm', '<cmd>Obsidian tomorrow<CR>', { desc = 'Tomorrows note' })
map('n', '<leader>ody', '<cmd>Obsidian yesterday<CR>', { desc = 'Yesterdays note' })
map('n', '<leader>on', '<cmd>Obsidian new<CR>', { desc = 'New note' })
map('n', '<leader>of', '<cmd>Obsidian quick_switch<CR>', { desc = 'Find note' })
map('n', '<leader>os', '<cmd>Obsidian search<CR>', { desc = 'Search notes' })
map('n', '<leader>ob', '<cmd>Obsidian backlinks<CR>', { desc = 'Backlinks' })
map('n', '<leader>ol', '<cmd>Obsidian follow_link<CR>', { desc = 'Follow link' })

-- -- keymap to sync the vault with git
-- vim.keymap.set('n', '<leader>ovs', function()
--   local vault_path = os.getenv 'HOME' .. '/Obsidian/pkm-vault'
--   local handle = io.popen "date '+%Y-%m-%d %H:%M:%S'"
--   local datetime = handle:read('*a'):gsub('\n', '')
--   handle:close()
--   local commit_msg = 'work vault backup: ' .. datetime
--   local function run_git(cmd)
--     vim.fn.system('cd ' .. vault_path .. ' && ' .. cmd)
--   end
--   run_git 'git add .'
--   run_git("git commit -m '" .. commit_msg .. "'")
--   run_git 'git push'
--   print('Vault synced: ' .. commit_msg)
-- end, { desc = 'Sync Obsidian vault with git', silent = false })
