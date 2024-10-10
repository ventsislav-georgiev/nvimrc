return {
  'mg979/vim-visual-multi',
  branch = 'master',
  init = function()
    vim.g.VM_default_mappings = 0
    vim.g.VM_set_statusline = 0
    vim.g.VM_silent_exit = 2
    vim.g.VM_quit_after_leaving_insert_mode = 2
    vim.g.VM_show_warnings = 0
    -- vim.g.VM_highlight_matches = ''

    vim.g.VM_maps = {
      ['Undo'] = '<D-z>',
      ['Redo'] = '<D-Z>',
      ['Find Under'] = '<D-d>',
      ['Skip Region'] = '<D-s>',
      ['Select h'] = '<S-Left>',
      ['Select l'] = '<S-Right>',
      ['Add Cursor Up'] = '<D-Up>',
      ['Find Subword Under'] = '<D-d>',
      ['Add Cursor Down'] = '<D-Down>',
      ['Mouse Cursor'] = '<D-LeftMouse>',
      ['Mouse Column'] = '<D-RightMouse>',
    }

    vim.g.VM_custom_remaps = {
      ['<C-c>'] = '<Esc>',
    }
  end,
}
