-- Comment plugins
return {
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
  {
    'tpope/vim-commentary',
    init = function()
      vim.cmd [[autocmd FileType terraform setlocal commentstring=#\ %s]]
      vim.cmd [[autocmd FileType terraform-vars setlocal commentstring=#\ %s]]
    end,
  },
}
