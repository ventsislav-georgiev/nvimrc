local dap = require 'dap'
local dapui = require 'dapui'
local dapui_widgets = require 'dap.ui.widgets'
local dap_python = require 'dap-python'
local dap_go = require 'dap-go'

local function eval_enter()
  dapui.eval(nil, { enter = true })
end

local function debug_test_method()
  local filetype = vim.bo.filetype
  if filetype == 'python'  then
    dap_python.test_method()
  elseif filetype == 'go' then
    dap_go.debug_test()
  else
    print('No test method for filetype: ' .. filetype)
  end
end

vim.keymap.set('n', '<leader>dx', dap.clear_breakpoints, { desc = 'Clear Breakpoints' })
vim.keymap.set('n', '<leader>dm', debug_test_method, { desc = 'Test [M]ethod' })

vim.keymap.set('n', '<leader>duc', dapui.close, { desc = '[C]lose UI' })
vim.keymap.set('n', '<leader>dus', function() dapui.toggle({ layout = 1 }) end, { desc = '[T]oggle Side UI' })
vim.keymap.set('n', '<leader>dub', function() dapui.toggle({ layout = 2 }) end, { desc = '[T]oggle Bottom UI' })
vim.keymap.set('n', '<leader>dur', function() dapui.open({ reset = true }) end, { desc = '[R]eset UI' })

vim.keymap.set('n', '<leader>ds', function()
  dapui_widgets.centered_float(dapui_widgets.scopes)
end, { desc = 'Scopes' })

vim.keymap.set('n', '<leader>dh', function()
  dapui_widgets.centered_float(dapui_widgets.threads)
end, { desc = 'T[h]reads' })

vim.keymap.set('n', '<leader>da', function()
  if dap.defaults.fallback.exception_breakpoints == default_exception_breakpoints then
    dap.defaults.fallback.exception_breakpoints = { 'all' }
  else
    dap.defaults.fallback.exception_breakpoints = default_exception_breakpoints
  end
end, { desc = 'Toggle break on startup' })

vim.keymap.set('n', '<D-\\>', function()
  if dap.session() then
    dap.continue()
  else
    dap.run_last()
  end
end, { desc = 'Continue/Run Last' })

vim.keymap.set('n', '<D-B>', function()
  dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
end, { desc = 'Breakpoint [C]ondition' })
vim.keymap.set('n', '<D-L>', function()
  dap.set_breakpoint(nil, nil, vim.fn.input 'Log point message: ')
end, { desc = 'Log [L]ogpoint' })

vim.keymap.set('n', '<D-3>', dap.terminate, { desc = 'Stop' })
vim.keymap.set('n', '<D-4>', dap.restart, { desc = 'Restart' })
vim.keymap.set('n', '<D-;>', dap.step_into, { desc = 'Step Into' })
vim.keymap.set('n', "<D-'>", dap.step_over, { desc = 'Step Over' })
vim.keymap.set('n', '<D-S-:>', dap.step_out, { desc = 'Step Out' })
vim.keymap.set('n', '<D-S-">', dap.step_back, { desc = 'Step Back' })
vim.keymap.set('n', '<D-r>', dap.run_to_cursor, { desc = '[R]un to [C]ursor' })
vim.keymap.set('n', '<D-e>', eval_enter, { desc = '[E]val under [C]ursor' })
vim.keymap.set('n', '<S-L>', eval_enter, { desc = '[E]val under [C]ursor' })
vim.keymap.set('n', '<D-`>', dap.repl.toggle, { desc = '[R]epl Toggle' })
