local dapui = require 'dapui'
local dapvt = require 'nvim-dap-virtual-text'

-- Signs
vim.fn.sign_define('DapBreakpoint', { text = '🟥' })
vim.fn.sign_define('DapBreakpointCondition', { text = '🟧' })
vim.fn.sign_define('DapLogPoint', { text = '🟩' })
vim.fn.sign_define('DapStopped', { text = '➤' })
vim.fn.sign_define('DapBreakpointRejected', { text = '⬜' })

-- Config
dapui.setup {
  mappings = {
    expand = { '<LeftMouse>', '<right>', '<left>' },
    open = '<CR>',
    remove = 'd',
    edit = 'e',
    repl = 'r',
    toggle = 't',
  },
  icons = {
    collapsed = '▸',
    expanded = '▾',
    current_frame = '›',
  },
  expand_lines = true,
  layouts = {
    {
      elements = {
        -- 'watches',
        -- 'stacks',
        -- 'scopes',
        -- 'breakpoints',
        { id = 'stacks', size = 0.50 },
        { id = 'scopes', size = 0.50 },
        -- { id = 'watches', size = 0.20 },
      },
      size = 40,
      position = 'left',
    },
    {
      elements = {
        'repl',
        -- { id = 'repl', size = 0.35 },
        -- { id = 'console', size = 0.65 },
      },
      size = 10,
      position = 'bottom',
    },
  },
  floating = {
    max_height = nil,
    max_width = nil,
    border = 'rounded',
    mappings = {
      close = { 'q', '<Esc>' },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil,
  },
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'dap-float',
  callback = function()
    vim.api.nvim_buf_set_keymap(0, 'n', 'q', '<cmd>close!<CR>', { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, 'n', '<esc>', '<cmd>close!<CR>', { noremap = true, silent = true })
  end,
})

dapvt.setup {
  enabled = true,
  enable_commands = false,
  highlight_changed_variables = false,
  highlight_new_as_changed = false,
  show_stop_reason = true,
  commented = true,
  only_first_definition = false,
  all_references = false,
  filter_references_pattern = '<module',
  virt_text_pos = 'eol',
  all_frames = false,
  virt_lines = false,
  -- virt_text_win_col = 80,
}

-- dap.listeners.before.attach.dapui_config = function()
--   dapui.open()
-- end
-- dap.listeners.before.launch.dapui_config = function()
--   dapui.open()
-- end
-- dap.listeners.before.event_terminated.dapui_config = function()
--   dapui.close()
-- end
-- dap.listeners.before.event_exited.dapui_config = function()
--   dapui.close()
-- end

-- local c = require('vscode.colors').get_colors()
vim.api.nvim_set_hl(0, 'NvimDapVirtualText', {
  fg = '#FFCC55',
  bg = 'None',
})
