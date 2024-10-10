return {
  {
    -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      'nvim-telescope/telescope-ui-select.nvim',
      'jvgrootveld/telescope-zoxide',
      'debugloop/telescope-undo.nvim',
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      local z_utils = require 'telescope._extensions.zoxide.utils'

      require('telescope').setup {
        pickers = {
          find_files = {
            hidden = true,
          },
          oldfiles = {
            cwd_only = true,
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
          zoxide = {
            prompt_title = '[ Zoxide ]',
            mappings = {
              default = {
                after_action = function(selection)
                  print('Update to (' .. selection.z_score .. ') ' .. selection.path)
                end,
              },
              ['<C-s>'] = {
                before_action = function(selection)
                  print 'before C-s'
                end,
                action = function(selection)
                  vim.cmd.edit(selection.path)
                end,
              },
              ['<C-q>'] = { action = z_utils.create_basic_command 'split' },
            },
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension, 'zoxide')
      pcall(require('telescope').load_extension, 'undo')

      local file_ignore_patterns = {
        '%.git/',
        '%.gitlab/',
        'yarn%.lock',
        'node_modules/',
        'package%-lock%.json',
        'dist/',
        'build/',
        'vendor/',
        'out/',
        '%/output/',
      }

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })

      local files_search = function()
        builtin.find_files {
          find_command = { 'rg', '--files', '--hidden', '--no-ignore', '--glob', '!.git' },
          hidden = true,
          file_ignore_patterns = file_ignore_patterns,
        }
      end

      vim.keymap.set('n', '<leader>ss', files_search, { desc = '[S]earch Files' })

      if vim.g.neovide then
        vim.keymap.set('n', '<D-p>', files_search, { desc = '[S]earch Files' })
      end

      vim.keymap.set('n', '<leader>sw', function()
        builtin.grep_string {
          file_ignore_patterns = file_ignore_patterns,
        }
      end, { desc = '[S]earch current [W]ord' })

      vim.keymap.set('n', '<leader>sg', function()
        builtin.live_grep {
          file_ignore_patterns = file_ignore_patterns,
        }
      end, { desc = '[S]earch by [G]rep' })

      -- vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      -- vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sp', builtin.resume, { desc = '[S]earch [P]revious' })
      vim.keymap.set('n', '<leader><leader>', builtin.oldfiles, { desc = 'Recent Files' })
      vim.keymap.set('n', '<leader>s.', builtin.buffers, { desc = 'Find existing buffers' })

      -- Netrw
      vim.keymap.set('n', '<leader>bf', '<cmd>:Explore<CR>', { desc = '[B]rowse [F]iles' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      vim.keymap.set('n', '<leader>z', require('telescope').extensions.zoxide.list, { desc = '[C]hange [D]irectory' })
      -- vim.keymap.set('n', '<leader>u', '<cmd>Telescope undo<cr>')

      -- Diff view
      vim.keymap.set('n', '<leader>sv', ':DiffviewOpen<CR>', { desc = '[S]how Diff[V]iew' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })

      vim.keymap.set('n', '<leader>sc', function()
        builtin.find_files { cwd = vim.fn.expand '%:p:h' }
      end, { desc = '[S]earch [C]urrent files' })
    end,
  },
}
