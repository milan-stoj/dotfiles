vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Enable autoread
vim.o.autoread = true

-- Reload file automatically when changed outside of Neovim
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
    command = "checktime"
})
require 'config.options'
require 'config.autocmds'
require 'config.pack'
require 'plugins'
require 'config.keymaps'
require 'config.lsp'
