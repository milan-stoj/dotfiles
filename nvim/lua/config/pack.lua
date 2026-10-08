local function gh(repo)
  return 'https://github.com/' .. repo
end

-- Hooks must be registered before vim.pack.add().
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(event)
    if event.data.spec.name ~= 'nvim-treesitter' then
      return
    end
    if event.data.kind ~= 'install' and event.data.kind ~= 'update' then
      return
    end
    if not event.data.active then
      vim.cmd.packadd 'nvim-treesitter'
    end
    vim.cmd 'TSUpdate'
  end,
})

vim.pack.add {
  gh 'nvim-lua/plenary.nvim',
  gh 'nvim-neotest/nvim-nio',
  gh 'antoinemadec/FixCursorHold.nvim',
  gh 'nvim-neotest/neotest',
  gh 'nvim-neotest/neotest-jest',
  gh 'nsidorenco/neotest-vstest',
  gh 'MeanderingProgrammer/render-markdown.nvim',
  gh 'folke/tokyonight.nvim',
  gh 'gbprod/nord.nvim',
  gh 'sainnhe/everforest',
  gh 'ellisonleao/gruvbox.nvim',
  gh 'folke/snacks.nvim',
  gh 'folke/which-key.nvim',
  gh 'nvim-lualine/lualine.nvim',
  gh 'nvim-mini/mini.nvim',
  gh 'stevearc/oil.nvim',
  gh 'lewis6991/gitsigns.nvim',
  gh 'neovim/nvim-lspconfig',
  gh 'mason-org/mason.nvim',
  gh 'mason-org/mason-lspconfig.nvim',
  gh 'WhoIsSethDaniel/mason-tool-installer.nvim',
  gh 'seblyng/roslyn.nvim',
  { src = gh 'saghen/blink.cmp', version = vim.version.range '1.*' },
  gh 'rafamadriz/friendly-snippets',
  gh 'stevearc/conform.nvim',
  gh 'mfussenegger/nvim-lint',
  { src = gh 'nvim-treesitter/nvim-treesitter', version = 'main' },
  { src = gh 'obsidian-nvim/obsidian.nvim', version = vim.version.range '*' },
}
