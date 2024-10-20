return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VeryLazy',
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
      'nvim-telescope/telescope-dap.nvim',
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      local z_utils = require 'telescope._extensions.zoxide.utils'
      local actions = require 'telescope.actions'

      require('telescope').setup {
        defaults = {
          layout_strategy = 'vertical',
          layout_config = {
            vertical = { width = 0.6 },
          },
          file_ignore_patterns = {
            '^.git/',
            '^vendor/',
            '^node_modules/',
            '^dist/',
            '^build/',
            '^target/',
            '/output/',
            '^out/',
            '^__pycache__/',
            '^.pytest_cache/',
            '.DS_Store',
            '%(-|\\.)lock.*',
            '%.pyc',
          },
          mappings = {
            i = {
              ['<esc>'] = actions.close,
            },
          },
        },
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
                  local session = require('session_manager.config').dir_to_session_filename(selection.path)
                  if session:exists() then
                    require('session_manager.utils').load_session(session.filename, true)
                    return
                  end

                  local out =
                    vim.fn.system "fd --type f --hidden --no-ignore --max-depth 1 . | rg '(README|Dockerfile|index.html|main.go|package.json|.gitignore|Makefile|LICENSE)'"
                  local results = vim.fn.split(out, '\n')

                  if #results == 0 then
                    out = vim.fn.system 'fd --type f --hidden --no-ignore --max-depth 2 .'
                    results = vim.fn.split(out, '\n')
                  end

                  if #results == 0 then
                    print('No files found in ' .. selection.path)
                    vim.cmd 'Explore'
                    return
                  end

                  vim.cmd 'bufdo bd' -- Close all buffers
                  local file = selection.path .. '/' .. results[1]
                  vim.cmd('e ' .. file) -- Open file

                  require('session_manager').save_current_session()
                  require('session_manager').load_current_dir_session()
                end,
              },
            },
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension, 'zoxide')
      pcall(require('telescope').load_extension, 'undo')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })

      local files_search = function()
        builtin.find_files {
          find_command = { 'rg', '--files', '--hidden', '--no-ignore', '--glob', '!.git' },
          hidden = true,
        }
      end

      vim.keymap.set('n', '<leader>ss', files_search, { desc = '[S]earch Files' })
      vim.keymap.set('n', '<D-p>', files_search, { desc = '[S]earch Files' })

      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })

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

      -- Undo history
      vim.keymap.set('n', '<leader>u', '<cmd>Telescope undo<cr>')

      -- Diff view
      vim.keymap.set('n', '<leader>sv', ':DiffviewOpen<CR>', { desc = '[S]how Diff[V]iew' })

      -- DAP
      local function dapcmd(arg)
        pcall(require('telescope').load_extension, 'dap')
        vim.cmd('Telescope dap ' .. arg)
      end

      vim.keymap.set('n', '<leader>dc', function()
        dapcmd 'commands'
      end, { desc = '[C]ommands' })
      vim.keymap.set('n', '<leader>db', function()
        dapcmd 'list_breakpoints'
      end, { desc = '[B]reakpoints' })
      vim.keymap.set('n', '<leader>df', function()
        dapcmd 'frames'
      end, { desc = '[F]rames' })
      vim.keymap.set('n', '<leader>dv', function()
        dapcmd 'variables'
      end, { desc = '[V]ariables' })
      vim.keymap.set('n', '<leader>dg', function()
        dapcmd 'configurations'
      end, { desc = 'Confi[g]urations' })

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
