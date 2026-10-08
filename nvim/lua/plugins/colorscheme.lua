-- vim.o.termguicolors = true
-- vim.o.background = 'dark'
-- vim.g.everforest_background = 'dark'
--
-- vim.cmd.colorscheme 'everforest'

-- require('nord').setup {
--   transparent = true,
--   terminal_colors = true,
--   borders = true,
--   styles = {
--     comments = { italic = true },
--   },
-- }
--
-- vim.cmd.colorscheme 'nord'

-- require('gruvbox').setup {
--   contrast = 'hard',
--   transparent_mode = false,
-- }

-- vim.o.background = 'dark'
-- vim.cmd.colorscheme 'gruvbox'

vim.cmd.colorscheme 'tokyonight-night'
require('tokyonight').setup {
  style = 'night',
  styles = { comments = { italic = true }, keywords = { italic = true } },
}
vim.cmd.colorscheme 'tokyonight-night'
