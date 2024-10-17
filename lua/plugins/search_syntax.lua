return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('nvim-treesitter.configs').setup {
      textobjects = {
        swap = {
          enable = true,
          swap_next = {
            ['mpn'] = '@parameter.inner',
          },
          swap_previous = {
            ['mpl'] = '@parameter.inner',
          },
        },

        move = {
          enable = true,
          goto_next_start = {
            [']]'] = '@function.outer',
            ['}}'] = '@block.outer',
          },
          goto_next_end = {
            [']['] = '@function.outer',
            ['}{'] = '@block.outer',
          },
          goto_previous_start = {
            ['[['] = '@function.outer',
            ['{{'] = '@block.outer',
          },
          goto_previous_end = {
            ['[]'] = '@function.outer',
            ['{}'] = '@block.outer',
          },
        },
      },
    }
  end,
}
