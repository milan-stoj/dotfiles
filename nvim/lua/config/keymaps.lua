-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- Keymap to open the index.md file in Obsidian vault
vim.keymap.set('n', '<leader>oi', function()
  vim.cmd 'edit ~/Obsidian/pkm-vault/300-maps/index.md'
end, { desc = 'Open Obsidian index file' })

-- Keymap to open today's daily note in Obsidian
vim.keymap.set('n', '<leader>odt', function()
  -- Load the obsidian.nvim plugin using lazy.nvim
  require('lazy').load { plugins = { 'obsidian.nvim' } }
  -- Run the ObsidianToday command
  vim.cmd 'ObsidianToday'
end, { desc = "Open today's daily note in Obsidian" })

-- Keymap to open tomorrows daily not in buffer
vim.keymap.set('n', '<leader>odm', function()
  -- Load the obsidian.nvim plugin using lazy.nvim
  require('lazy').load { plugins = { 'obsidian.nvim' } }
  -- Run the ObsidianTomorrow command
  vim.cmd 'ObsidianTomorrow'
end, { desc = "Open tomorrow's daily note in Obsidian" })

-- Keymap to open yesterdays daily note in buffer
vim.keymap.set('n', '<leader>ody', function()
  -- Load the obsidian.nvim plugin using lazy.nvim
  require('lazy').load { plugins = { 'obsidian.nvim' } }
  -- Run the ObsidianYesterday command
  vim.cmd 'ObsidianYesterday'
end, { desc = "Open yesterday's daily note in Obsidian" })

-- keymap to sync the vault with git
vim.keymap.set('n', '<leader>ovs', function()
  local vault_path = os.getenv 'HOME' .. '/Obsidian/pkm-vault'
  local handle = io.popen "date '+%Y-%m-%d %H:%M:%S'"
  local datetime = handle:read('*a'):gsub('\n', '')
  handle:close()
  local commit_msg = 'work vault backup: ' .. datetime
  local function run_git(cmd)
    vim.fn.system('cd ' .. vault_path .. ' && ' .. cmd)
  end
  run_git 'git add .'
  run_git("git commit -m '" .. commit_msg .. "'")
  run_git 'git push'
  print('Vault synced: ' .. commit_msg)
end, { desc = 'Sync Obsidian vault with git', silent = false })
