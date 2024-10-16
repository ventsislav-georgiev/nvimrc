return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree dir=<C-r>=getcwd()<CR> reveal_file=%:p<CR>', desc = 'NeoTree reveal', silent = true },
    { '<D-E>', ':Neotree dir=<C-r>=getcwd()<CR> reveal_file=%:p<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    window = {
      position = 'current',
      mappings = {
        ['<left>'] = 'close_node',
        ['<right>'] = 'open',
      },
    },
    filesystem = {
      follow_current_file = {
        enabled = true,
        leave_dirs_open = true,
      },
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_hidden = false,
      },
      window = {
        mappings = {
          ['\\'] = 'close_window',
          ['<D-E>'] = 'close_window',
        },
      },
    },
    buffers = {
      follow_current_file = {
        enabled = true,
        leave_dirs_open = true,
      },
    },
    default_component_configs = {
      git_status = {
        symbols = {
          -- Change type
          added = '✚',
          deleted = '✖',
          modified = '',
          renamed = '󰁕',
          -- Status type
          untracked = '',
          ignored = '',
          unstaged = '', -- NOTE: you can set any of these to an empty string to not show them
          staged = '',
          conflict = '',
        },
        align = 'right',
      },
    },
  },
}
