require('mini.icons').setup()
local icons = require 'mini.icons'
icons.setup()
icons.mock_nvim_web_devicons()
require('mini.pairs').setup()
require('mini.surround').setup()
require('mini.ai').setup {
  n_lines = 500,
  mappings = { around_next = 'aa', inside_next = 'ii' },
}
