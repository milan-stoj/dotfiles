require('which-key').setup {
  preset = 'modern',
  delay = 300,
  spec = {
    { '<leader><TAB>', group = 'Tabs' },
    { '<leader>w', group = 'Windows' },
    { '<leader>g', group = 'Git' },
    { '<leader>f', group = 'Find' },
    { '<leader>b', group = 'Buffer' },
    { '<leader>c', group = 'Code' },
    { '<leader>s', group = 'Search' },
    { '<leader>t', group = 'Toggle' },
    { '<leader>o', group = 'Obsidian' },
    { '<leader>n', group = 'Nvim' },
  },
}

require('lualine').setup {
  options = {
    theme = 'auto',
    globalstatus = true,
    component_separators = { left = '│', right = '│' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch' },
    lualine_c = { { 'filename', path = 1 } },
    lualine_x = { 'diagnostics', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
}

require('render-markdown').setup {
  preset = 'obsidian',
}
