return {
  -- Make sure to set this up properly if you have lazy=true
  'MeanderingProgrammer/render-markdown.nvim',
  opts = {
    file_types = { 'markdown', 'Avante' },
    heading = {
      position = 'inline',
    },
    indent = {
      enabled = false,
    },
    quote = {
      repeat_linebreak = true,
    },
  },
  ft = { 'markdown', 'Avante' },
}
