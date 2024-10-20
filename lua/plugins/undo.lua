return {
  'jiaoshijie/undotree',
  lazy = true,
  dependencies = 'nvim-lua/plenary.nvim',
  config = true,
  keys = {
    { '<leader>tu', "<cmd>lua require('undotree').toggle()<cr>", desc = "Undotree" },
  },
  opts = {
    float_diff = true, -- using float window previews diff, set this `true` will disable layout option
    layout = 'left_bottom', -- "left_bottom", "left_left_bottom"
    position = 'left', -- "right", "bottom"
    ignore_filetype = { 'undotree', 'undotreeDiff', 'qf', 'TelescopePrompt', 'spectre_panel', 'tsplayground' },
    window = {
      winblend = 30,
    },
    keymaps = {
      ['<down>'] = 'move_next',
      ['<up>'] = 'move_prev',
      ['gj'] = 'move2parent',
      ['<S-down>'] = 'move_change_next',
      ['<S-up>'] = 'move_change_prev',
      ['<cr>'] = 'action_enter',
      ['p'] = 'enter_diffbuf',
      ['q'] = 'quit',
    },
  },
}
