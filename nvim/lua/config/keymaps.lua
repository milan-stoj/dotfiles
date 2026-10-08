-- ============================================================================
-- General / Misc
-- ============================================================================

local Snacks = require('snacks')
vim.keymap.set('n', '<leader>nr', '<cmd>restart<cr>', { desc = 'Restart Neovim and reload config.' })

--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('i', '<C-c>', '<Esc>', { desc = 'Exit insert mode' })

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
-- ============================================================================
-- Windows / Splits
-- ============================================================================
vim.keymap.set('n', '<leader>wv', '<cmd>vsplit<CR>', { desc = 'Split vertical' })
vim.keymap.set('n', '<leader>ws', '<cmd>split<CR>', { desc = 'Split horizontal' })
vim.keymap.set('n', '<leader>wc', '<cmd>close<CR>', { desc = 'Close window' })
vim.keymap.set('n', '<leader>wo', '<cmd>only<CR>', { desc = 'Close other windows' })

-- Move between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<A-k>', '<C-w>+', { desc = 'Increase height' })
vim.keymap.set('n', '<A-j>', '<C-w>-', { desc = 'Decrease height' })
vim.keymap.set('n', '<A-l>', '<C-w>>', { desc = 'Increase width' })
vim.keymap.set('n', '<A-h>', '<C-w><', { desc = 'Decrease width' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set('n', '<C-S-H>', '<C-w>H', { desc = 'Move window to the left' })
-- vim.keymap.set('n', '<C-S-L>', '<C-w>L', { desc = 'Move window to the right' })
-- vim.keymap.set('n', '<C-S-J>', '<C-w>J', { desc = 'Move window to the lower' })
-- vim.keymap.set('n', '<C-S-K>', '<C-w>K', { desc = 'Move window to the upper' })

-- ============================================================================
-- Buffers
-- ============================================================================
vim.keymap.set('n', '<leader>bn', '<cmd>bn<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<leader>bp', '<cmd>bp<CR>', { desc = 'Previous buffer' })
vim.keymap.set('n', '<leader>bd', function()
  Snacks.bufdelete()
end, { desc = 'Delete buffer' })

-- ============================================================================
-- Tabs / Workspaces
-- ============================================================================
vim.keymap.set('n', '<leader><TAB>n', '<cmd>tabnew<CR>', { desc = 'New tab' })
vim.keymap.set('n', '<leader><TAB>c', '<cmd>tabclose<CR>', { desc = 'Close tab' })
vim.keymap.set('n', '<leader><TAB>o', '<cmd>tabonly<CR>', { desc = 'Close other tabs' })
vim.keymap.set('n', '<leader><TAB>h', '<cmd>tabprevious<CR>', { desc = 'Previous tab' })
vim.keymap.set('n', '<leader><TAB>l', '<cmd>tabnext<CR>', { desc = 'Next tab' })
-- Jump to tabs
vim.keymap.set('n', '<leader><TAB>1', '1gt', { desc = 'Tab 1' })
vim.keymap.set('n', '<leader><TAB>2', '2gt', { desc = 'Tab 2' })
vim.keymap.set('n', '<leader><TAB>3', '3gt', { desc = 'Tab 3' })
vim.keymap.set('n', '<leader><TAB>4', '4gt', { desc = 'Tab 4' })
vim.keymap.set('n', '<leader><TAB>5', '5gt', { desc = 'Tab 5' })

--

local function open_project_tab()
  local dir = vim.fn.input('Project directory: ', vim.fn.expand '~/', 'dir')
  if dir == '' then
    return
  end

  dir = vim.fs.normalize(vim.fn.expand(dir))
  vim.cmd.tabnew()
  vim.cmd.tcd(vim.fn.fnameescape(dir))

  vim.api.nvim_tabpage_set_var(0, 'project_root', dir)
  Snacks.picker.files {
    cwd = dir,
  }
end

vim.keymap.set('n', '<leader><TAB>p', open_project_tab, { desc = 'Open a project in new tab' })

-- ============================================================================
-- Neotest
-- ============================================================================
local function testmap(key, callback, description)
  vim.keymap.set('n', '<leader>ct' .. key, function()
    callback(require 'neotest')
  end, { desc = 'Test: ' .. description })
end

testmap('n', function(t)
  t.run.run()
end, 'Run nearest')

testmap('f', function(t)
  t.run.run(vim.fn.expand '%:p')
end, 'Run file')

testmap('a', function(t)
  t.run.run(vim.fn.getcwd())
end, 'Run current directory')

testmap('l', function(t)
  t.run.run_last()
end, 'Run last')

testmap('d', function(t)
  t.run.run { strategy = 'dap' }
end, 'Debug nearest')

testmap('s', function(t)
  t.summary.toggle()
end, 'Toggle summary')

testmap('o', function(t)
  t.output.open { enter = true }
end, 'Show nearest result')

testmap('O', function(t)
  t.output_panel.toggle()
end, 'Toggle full output')

testmap('x', function(t)
  t.run.stop()
end, 'Stop nearest')

testmap('j', function(t)
  t.jump.next { status = 'failed' }
end, 'Next failure')

testmap('k', function(t)
  t.jump.prev { status = 'failed' }
end, 'Previous failure')
