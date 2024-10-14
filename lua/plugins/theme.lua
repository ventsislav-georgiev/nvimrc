return {
  'Mofiqul/vscode.nvim',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  config = function()
    local c = require('vscode.colors').get_colors()
    require('vscode').setup {
      -- Alternatively set style in setup
      -- style = 'light'

      -- Enable transparent background
      transparent = true,

      -- Enable italic comment
      italic_comments = true,

      -- Underline `@markup.link.*` variants
      underline_links = true,

      -- Disable nvim-tree background color
      disable_nvimtree_bg = true,

      -- Override colors (see ./lua/vscode/colors.lua)
      color_overrides = {
        vscLineNumber = '#666666',
      },

      -- Override highlight groups (see ./lua/vscode/theme.lua)
      group_overrides = {
        Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
        DiffAdd = { fg = 'None', bg = c.vscDiffGreenDark },
        DiffChange = { fg = 'None', bg = c.vscDiffGreenLight },
        DiffDelete = { fg = 'None', bg = c.vscDiffRedDark },
        DiffText = { fg = 'None', bg = c.vscDiffRedDark },
      },
    }
  end,
  init = function()
    vim.cmd.colorscheme 'vscode'

    -- You can configure highlights by doing something like:
    vim.cmd.hi 'Comment gui=none'
  end,
}
