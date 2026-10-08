return {
  -- Make sure to set this up properly if you have lazy=true
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-mini/mini.nvim' }, -- if you use the mini.nvim suite
  opts = {
    file_types = { 'markdown' },
    heading = {
      position = 'inline',
    },
    quote = {
      repeat_linebreak = true,
    },
  },
  ft = { 'markdown' },
}
