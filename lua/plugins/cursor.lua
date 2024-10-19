return {
  'jake-stewart/multicursor.nvim',
  branch = '1.0',
  config = function()
    local mc = require 'multicursor-nvim'

    mc.setup()

    local set = vim.keymap.set

    set('n', '<esc>', function()
      if not mc.cursorsEnabled() then
        mc.enableCursors()
      elseif mc.hasCursors() then
        mc.clearCursors()
      else
        vim.cmd 'nohlsearch'
      end
    end)

    -- Add cursors above/below the main cursor.
    set({ 'n', 'v' }, '<D-S-D>', function()
      mc.toggleCursor()
    end)
    set({ 'n', 'v' }, '<D-S-Up>', function()
      mc.addCursor 'k'
    end)
    set({ 'n', 'v' }, '<D-S-Down>', function()
      mc.addCursor 'j'
    end)

    -- Add cursors to the beginning/end of the file.
    set({ 'n', 'v' }, '<D-C-Up>', function()
      local pos = vim.api.nvim_win_get_cursor(0)
      while pos[1] > 1 do
        mc.addCursor 'k'
        pos = vim.api.nvim_win_get_cursor(0)
      end
    end)
    set({ 'n', 'v' }, '<D-C-Down>', function()
      local pos = vim.api.nvim_win_get_cursor(0)
      while pos[1] < vim.api.nvim_buf_line_count(0) do
        mc.addCursor 'j'
        pos = vim.api.nvim_win_get_cursor(0)
      end
    end)

    set({ 'n', 'v' }, '<D-Up>', function()
      if mc.hasCursors() then
        mc.lineSkipCursor(-1)
      else
        vim.cmd 'norm! gg'
      end
    end)
    set({ 'n', 'v' }, '<D-Down>', function()
      if mc.hasCursors() then
        mc.lineSkipCursor(1)
      else
        vim.cmd 'norm! G'
      end
    end)

    -- Add a cursor and jump to the next word under cursor.
    set('n', '<D-d>', 'viw')
    set('v', '<D-d>', function()
      mc.addCursor '*'
    end)

    set({ 'n', 'v' }, '<D-s>', function()
      if mc.hasCursors() then
        mc.matchSkipCursor(1)
      else
        vim.cmd 'update'
      end
    end)

    -- Add all matches in the document
    set({ 'n', 'v' }, '<D-S-A>', mc.matchAllAddCursors)

    -- Delete the main cursor.
    set('n', '<D-x>', function()
      if mc.hasCursors() then
        mc.deleteCursor()
      else
        vim.cmd 'norm! Vx'
      end
    end)

    -- Add and remove cursors with control + left click.
    set('n', '<D-leftmouse>', mc.handleMouse)

    -- Align cursor columns.
    set('v', '<D-f>', mc.alignCursors)

    -- Customize how cursors look.
    local hl = vim.api.nvim_set_hl
    hl(0, 'MultiCursorCursor', {
      fg = '#FFCC55',
      bg = '#774836',
    })
    hl(0, 'MultiCursorVisual', {
      fg = '#000000',
      bg = '#ffb342',
    })
    hl(0, 'MultiCursorSign', {
      fg = '#ffb342',
    })
    hl(0, 'MultiCursorDisabledCursor', {
      fg = '#c085fe',
      bg = '#000000',
    })
    hl(0, 'MultiCursorDisabledVisual', {
      fg = '#a3a3a3',
      bg = '#000000',
    })
    hl(0, 'MultiCursorDisabledSign', {
      fg = '#a3a3a3',
    })
  end,
}
