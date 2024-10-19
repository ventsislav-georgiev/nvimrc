return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local is_package_loaded = require('lazy').is_loaded
    local last_debug_exitcode = 0
    local event_listener_ready = false

    local debug_status = {
      function()
        local dap = require 'dap'

        if not event_listener_ready then
          dap.listeners.after.event_exited['print_exit'] = function(_, body)
            last_debug_exitcode = body.exitCode

            if body.exitCode ~= 0 then
              local msg = 'Debug session exited with code ' .. body.exitCode
              vim.api.nvim_echo({ { msg, 'ErrorMsg' } }, false, {})
            end
          end

          event_listener_ready = true
        end

        local status = dap.session()
        if status then
          return ''
        end
        return ''
      end,

      color = function()
        local color = { fg = '#000000' }
        if last_debug_exitcode ~= 0 then
          color.fg = '#ff0000'
        end
        if is_package_loaded 'nvim-dap' then
          local status = require('dap').session()
          if status then
            color.fg = '#00ff00'
          end
        end
        return color
      end,

      cond = function()
        return is_package_loaded 'nvim-dap'
      end,
    }

    local function cwd()
      return vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
    end

    local selection = {
      function()
        local starts = vim.fn.line 'v'
        local ends = vim.fn.line '.'
        local count = starts <= ends and ends - starts + 1 or starts - ends + 1
        local wc = vim.fn.wordcount()
        return 'lines: ' .. count .. ' characters: ' .. wc['visual_chars']
      end,

      cond = function()
        return vim.fn.mode():find '[Vv]' ~= nil
      end,
    }

    require('lualine').setup {
      theme = 'vscode',
      options = {
        ignore_focus = {
          'dapui_watches',
          'dapui_breakpoints',
          'dapui_scopes',
          'dapui_console',
          'dapui_stacks',
          'dap-repl',
        },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = {
          cwd,
          {
            'branch',
          },
          -- {
          --   'diagnostics',
          --
          --   -- Table of diagnostic sources, available sources are:
          --   --   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
          --   -- or a function that returns a table as such:
          --   --   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
          --   sources = { 'nvim_diagnostic', 'coc' },
          --
          --   -- Displays diagnostics for the defined severity types
          --   sections = { 'error', 'warn', 'info', 'hint' },
          --
          --   diagnostics_color = {
          --     -- Same values as the general color option can be used here.
          --     error = 'DiagnosticError', -- Changes diagnostics' error color.
          --     warn = 'DiagnosticWarn', -- Changes diagnostics' warn color.
          --     info = 'DiagnosticInfo', -- Changes diagnostics' info color.
          --     hint = 'DiagnosticHint', -- Changes diagnostics' hint color.
          --   },
          --   symbols = { error = 'E', warn = 'W', info = 'I', hint = 'H' },
          --   colored = true, -- Displays diagnostics status in color if set to true.
          --   update_in_insert = false, -- Update diagnostics in insert mode.
          --   always_visible = false, -- Show diagnostics even if there are none.
          -- },
        },
        lualine_c = {}, -- { { 'filename', color = { fg = '#666666' } } },
        lualine_x = { { 'b:gitsigns_blame_line', color = { fg = '#666666' } } },
        lualine_y = { 'filetype', 'diff', 'diagnostics' },
        lualine_z = { 'location', selection, debug_status },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
    }
  end,
}
