return {
  'github/copilot.vim',
  {
    'neoclide/coc.nvim',
    branch = 'release',
    dependencies = { 'github/copilot.vim' },
  },
  {
    'Wansmer/treesj',
    lazy = true,
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
}
