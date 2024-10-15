return {
  'mg979/vim-visual-multi',
  branch = 'master',
  init = function()
    vim.g.VM_default_mappings = 0
    vim.g.VM_set_statusline = 0
    vim.g.VM_silent_exit = 2
    vim.g.VM_quit_after_leaving_insert_mode = 0
    vim.g.VM_show_warnings = 0
    -- vim.g.VM_highlight_matches = ''

    vim.g.VM_maps = {
      ['Add Cursor Up'] = '<D-S-Up>',
      ['Add Cursor Down'] = '<D-S-Down>',
      ['Skip Region'] = '<D-s>',
      ['Find Under'] = '<D-d>',
      ['Find Subword Under'] = '<D-d>',
      ['Select h'] = '<S-Left>',
      ['Select l'] = '<S-Right>',
      -- ['Undo'] = '<D-z>',
      -- ['Redo'] = '<D-Z>',
      ['Mouse Cursor'] = '<D-LeftMouse>',
      ['Mouse Column'] = '<D-RightMouse>',
    }

    vim.g.VM_custom_remaps = {
      ['<C-c>'] = '<Esc>',
    }
  end,
}
