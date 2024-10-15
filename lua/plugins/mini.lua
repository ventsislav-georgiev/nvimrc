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
    -- - csaaqb - [S]urround [A]dd [A]rround [Q]uotes [B]rackets
    -- - csdq   - [S]urround [D]elete [Q]uotes
    -- - csrb'  - [S]urround [R]eplace [B]rackets [']
    require('mini.surround').setup {
      -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
      highlight_duration = 500,
      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        add = 'csa', -- Add surrounding in Normal and Visual modes
        delete = 'csd', -- Delete surrounding
        find = 'csf', -- Find surrounding (to the right)
        find_left = 'csF', -- Find surrounding (to the left)
        highlight = 'csh', -- Highlight surrounding
        replace = 'csr', -- Replace surrounding
        update_n_lines = 'csn', -- Update `n_lines`

        suffix_last = 'l', -- Suffix to search with "prev" method
        suffix_next = 'n', -- Suffix to search with "next" method
      },
      -- Number of lines within which surrounding is searched
      n_lines = 100,
    }
  end,
}
