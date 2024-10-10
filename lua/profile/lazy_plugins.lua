require('lazy').setup {
  require 'plugins.cursor',
  -- require 'plugins.debug',
  require 'plugins.editorconfig',
  -- require 'plugins.mini',

  require 'plugins.explorer',
  require 'plugins.explorer_batchedit',

  require 'plugins.help_whichkey',

  require 'plugins.lsp_autoformat',
  require 'plugins.lsp_autopairs',
  require 'plugins.lsp_comment',
  -- require 'plugins.lsp_indentguide',
  require 'plugins.lsp_lint',
  require 'plugins.lsp_refactor',
  require 'plugins.lsp_syntax',

  require 'plugins.search_global',
  require 'plugins.search_jump',
  require 'plugins.search_telescope',
  require 'plugins.search_zoxide',

  require 'plugins.terminal',
  require 'plugins.sessions',
  require 'plugins.theme',
  require 'plugins.undo',

  require 'plugins.version_control',
  require 'plugins.version_control_gitsigns',
  require 'plugins.version_control_lazygit',

  require 'plugins.window_cmdline',
  require 'plugins.window_statusline',
  require 'plugins.window_tabs',
}
