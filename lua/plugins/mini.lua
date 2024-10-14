return {
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - vab  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ciq  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiwb - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sdq   - [S]urround [D]elete [']quotes
      -- - srb'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()
    end,
  }
