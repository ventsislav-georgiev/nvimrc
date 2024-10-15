return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local dap = require 'dap'

    local function debug()
      local status = dap.session()
      if status then
        return ''
      end
      return ''
    end

    local function cwd()
      local cwd = vim.fn.getcwd()
      local cwd_name = vim.fn.fnamemodify(cwd, ":t")
      return cwd_name
    end

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
        lualine_z = { 'location', debug },
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
