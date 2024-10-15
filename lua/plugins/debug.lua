return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'theHamsta/nvim-dap-virtual-text',
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
      'leoluz/nvim-dap-go',
      'mfussenegger/nvim-dap-python',
    },
    config = function()
      local dap = require 'dap'

      -- Break on uncaught by default
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
