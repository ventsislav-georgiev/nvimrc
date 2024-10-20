return {
  {
    'github/copilot.vim',
    event = { 'VeryLazy', 'BufRead' },
  },
  {
    'neoclide/coc.nvim',
    event = { 'VeryLazy', 'BufRead' },
    branch = 'release',
    dependencies = { 'github/copilot.vim' },
  },
  {
    'Wansmer/treesj',
    lazy = true,
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
}
