local Snacks = require 'snacks'
Snacks.setup {
  bigfile = { enabled = true },
  dashboard = {
    enabled = true,

    sections = {
      {
        section = 'terminal',
        cmd = [[curl -fsS --max-time 5 'https://wttr.in/Milwaukee?1FQ' 2>/dev/null || printf 'Weather unavailable\n']],
        align = "center",
        height = 15,
        width = 130,
        indent = -32,
        padding = 1,
        ttl = 1000,
      },
      function()
        return {
          header = table.concat({
            os.date '%A, %B %d, %Y',
            os.date '%I:%M %p',
          }, '\n'),
          align = "center",
          padding = 1,
        }
      end,


      { section = 'keys', padding = 1 },
      { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 2 },
      { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
    },
  },
  explorer = { enabled = true, replace_netrw = true },
  indent = { enabled = true },
  input = { enabled = true },
  image = { enabled = true },
  notifier = { enabled = true, timeout = 5000 },
  picker = { enabled = true, ui_select = true },
  statuscolumn = { enabled = true },
  scroll = { enabled = true },
  quickfile = { enabled = true },
  lazygit = {
    configure = true,
  },
  scratch = { ft = 'markdown' },
  scope = { enabled = true },
  words = { enabled = true },
}

local map = vim.keymap.set
map('n', '<leader>fc', function()
  Snacks.picker.files {
    cwd = vim.fn.stdpath 'config',
  }
end, { desc = 'Find neovim config files' })
map('n', '<leader>ff', function()
  Snacks.picker.files()
end, { desc = 'Find files' })
map('n', '<leader>fg', function()
  Snacks.picker.grep()
end, { desc = 'Live grep' })
map('n', '<leader>fr', function()
  Snacks.picker.recent()
end, { desc = 'Recent files' })
map('n', '<leader>fb', function()
  Snacks.picker.buffers()
end, { desc = 'Buffers' })
map('n', '\\', function()
  Snacks.explorer()
end, { desc = 'Explorer', nowait = true })
map('n', '<leader>sb', function()
  Snacks.picker.lines()
end, { desc = 'Help' })
map('n', '<leader>sh', function()
  Snacks.picker.help()
end, { desc = 'Help' })
map('n', '<leader>sk', function()
  Snacks.picker.keymaps()
end, { desc = 'Keymaps' })
map('n', '<leader>sd', function()
  Snacks.picker.diagnostics()
end, { desc = 'Diagnostics' })
map('n', '<leader>ss', function()
  Snacks.picker.lsp_symbols()
end, { desc = 'Symbols' })
map('n', '<leader>gg', function()
  Snacks.lazygit()
end, { desc = 'LazyGit' })
map('n', '<leader>gB', function()
  Snacks.picker.git_branches()
end, { desc = 'Git branches' })
map('n', '<C-\\>', function()
  Snacks.terminal()
end, { desc = 'Terminal' })

map('n', '<leader>.', function()
  Snacks.scratch()
end, { desc = 'Scratch buffer' })

map('n', '<leader>tz', function()
  Snacks.zen()
end, { desc = 'Toggle zen mode' })
