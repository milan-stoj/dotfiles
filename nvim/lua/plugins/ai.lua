local Snacks = require 'snacks'

local function toggle_copilot()
  Snacks.terminal.toggle('copilot', {
    cwd = vim.fn.getcwd(),
    win = {
      position = 'right',
      width = 0.33,
    },
  })
end

vim.keymap.set({ 'n', 't' }, '<leader>cc', toggle_copilot, {
  desc = 'Toggle copilot chat',
})

