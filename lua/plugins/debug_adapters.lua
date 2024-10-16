local dap = require 'dap'
local mason_path = vim.fn.stdpath 'data' .. '/mason'

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
dap_go.setup {
  delve = {
    path = mason_path .. '/bin/dlv',
  },
}

-- TypeScript / Deno
local js_debug_dir = mason_path .. '/packages/js-debug-adapter/js-debug/src/dapDebugServer.js'

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
    stopOnEntry = false,
    env = {
      DENO_SCRIPT = './scripts/report-oncall/main.ts',
    },
  },
}

-- C/C++/Rust
dap.adapters.codelldb = {
  type = 'server',
  port = '${port}',
  executable = {
    command = mason_path .. '/bin/codelldb',
    args = { '--port', '${port}' },
  },
}

dap.configurations.c = {
  {
    name = 'Launch file',
    type = 'codelldb',
    request = 'launch',
    program = '${file}',
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}

dap.configurations.cpp = dap.configurations.c
dap.configurations.rust = dap.configurations.c
