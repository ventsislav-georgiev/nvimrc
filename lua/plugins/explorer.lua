return {
  'nvim-neo-tree/neo-tree.nvim',
  lazy = true,
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
        ['Y'] = function(state)
          -- NeoTree is based on [NuiTree](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree)
          -- The node is based on [NuiNode](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree#nuitreenode)
          local node = state.tree:get_node()
          local filepath = node:get_id()
          local filename = node.name
          local modify = vim.fn.fnamemodify

          local results = {
            filepath,
            modify(filepath, ':.'),
            modify(filepath, ':~'),
            filename,
            modify(filename, ':r'),
            modify(filename, ':e'),
          }

          vim.ui.select({
            '1. Absolute path: ' .. results[1],
            '2. Path relative to CWD: ' .. results[2],
            '3. Path relative to HOME: ' .. results[3],
            '4. Filename: ' .. results[4],
            '5. Filename without extension: ' .. results[5],
            '6. Extension of the filename: ' .. results[6],
          }, { prompt = 'Choose to copy to clipboard:' }, function(choice)
            local i = tonumber(choice:sub(1, 1))
            local result = results[i]
            vim.fn.setreg('+', result)
            vim.notify('Copied: ' .. result)
          end)
        end,
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
