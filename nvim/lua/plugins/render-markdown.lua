return {
  -- Make sure to set this up properly if you have lazy=true
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' }, -- if you use the mini.nvim suite
  opts = {
    file_types = { 'markdown' },
    heading = {
      position = 'inline',
    },
    -- indent = {
    --   enabled = true,
    --   render_modes = true,
    --   highlight = 'RenderMarkdownIndent',
    -- },
    quote = {
      repeat_linebreak = true,
    },
  },
  ft = { 'markdown' },
}
