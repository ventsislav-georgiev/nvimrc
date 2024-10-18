return {
  'ggandor/leap.nvim',
  dependencies = { 'tpope/vim-repeat' },
  init = function()
    vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap-forward)')
    vim.keymap.set({ 'n', 'x', 'o' }, 'S', '<Plug>(leap-backward)')
  end,
}
