return {
  'ggandor/leap.nvim',
  event = 'VeryLazy',
  dependencies = { 'tpope/vim-repeat' },
  config = function()
    require('leap').setup {}
    vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap-forward)')
    vim.keymap.set({ 'n', 'x', 'o' }, 'S', '<Plug>(leap-backward)')
  end,
}
