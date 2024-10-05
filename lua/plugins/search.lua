return {
  'nvim-pack/nvim-spectre',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('spectre').setup {
      is_insert_mode = true,
      lnum_for_results = true,
    }
  end,
}
