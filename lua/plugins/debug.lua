return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'williamboman/mason.nvim',
      'theHamsta/nvim-dap-virtual-text',
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
      'leoluz/nvim-dap-go',
      'mfussenegger/nvim-dap-python',
    },
    config = function()
      require("mason").setup()

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
