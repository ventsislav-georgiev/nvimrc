return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  config = function()
    require('noice').setup {
      presets = {
        bottom_search = false,
        command_palette = true,
        long_message_to_split = true,
      },
      cmdline = {
        format = {
          cmdline = { title = '' },
          search_down = { title = '' },
          search_up = { title = '' },
          filter = { title = '' },
          lua = { title = '' },
          help = { title = '' },
          input = { title = '' },
        },
        opts = {
          border = {
            style = 'single',
          },
        },
      },
      routes = {
        {
          view = 'notify',
          filter = { event = 'msg_showmode' },
        },
        {
          filter = {
            event = 'msg_show',
            kind = '',
            find = 'written',
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = 'msg_show',
            kind = '',
            find = 'The only match',
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = 'msg_show',
            kind = '',
            find = 'Fuzzy',
          },
          opts = { skip = true },
        },
      },
      win_options = {
        border = {
          style = 'single',
        },
      },
    }
  end,
}
