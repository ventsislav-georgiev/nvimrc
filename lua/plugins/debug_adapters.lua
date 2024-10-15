local dap = require 'dap'
local config_dir = vim.fn.stdpath 'config'


-- Python
local dap_python = require 'dap-python'

dap_python.setup 'python'
dap_python.test_runner = 'pytest'

dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = 'Launch file',
    program = '${file}',
  },
}


-- Go
local dap_go = require 'dap-go'
dap_go.setup {}


-- TypeScript / Deno
local js_debug_dir = config_dir .. '/dap/js-debug/src/dapDebugServer.js'

dap.adapters['pwa-node'] = {
  type = 'server',
  host = 'localhost',
  port = '${port}',
  executable = {
    command = 'node',
    args = { js_debug_dir, '${port}' },
  },
}

dap.configurations.typescript = {
  {
    type = 'pwa-node',
    request = 'launch',
    name = 'Launch Deno file',
    runtimeExecutable = 'deno',
    runtimeArgs = {
      'run',
      '--inspect-wait',
      '--allow-all',
    },
    program = '${file}',
    cwd = '${workspaceFolder}',
    attachSimplePort = 9229,
    env = {
      DENO_SCRIPT = './scripts/report-oncall/main.ts',
    },
  },
}
