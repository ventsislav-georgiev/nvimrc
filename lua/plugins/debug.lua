return {
  {
    'williamboman/mason.nvim',
    lazy = true,
    config = function()
      require('mason').setup {}
    end,
  },
  {
    'mfussenegger/nvim-dap',
    lazy = true,
    dependencies = {
      'theHamsta/nvim-dap-virtual-text',
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
      'leoluz/nvim-dap-go',
      { 'mfussenegger/nvim-dap-python', lazy = true },
    },
    config = function()
      -- Break on uncaught by default
      local dap = require 'dap'
      local default_exception_breakpoints = { 'uncaught', 'rust_panic' }
      dap.defaults.fallback.exception_breakpoints = default_exception_breakpoints

      -- UI
      require 'plugins.debug_ui'

      -- Adapters
      require 'plugins.debug_adapters'

      -- Shortcuts
      require 'plugins.debug_shortcuts'
    end,
  },
}
