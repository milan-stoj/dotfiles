require("oil").setup({
  default_file_explorer = false,
  view_options = { show_hidden = true },
  float = { padding = 2, border = "rounded" },
})
vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open parent directory" })
