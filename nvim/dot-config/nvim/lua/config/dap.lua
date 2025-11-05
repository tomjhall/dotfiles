local dap = require("dap")

-- Configure vscode-js-debug adapter
dap.adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    args = {
      vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
      "${port}",
    },
  },
}

-- TypeScript/JavaScript configurations
dap.configurations.typescript = {
  {
    name = "Launch API (yarn dev)",
    type = "pwa-node",
    request = "launch",
    runtimeExecutable = "yarn",
    runtimeArgs = { "dev" },
    rootPath = "${workspaceFolder}",
    cwd = "${workspaceFolder}",
    console = "integratedTerminal",
    internalConsoleOptions = "neverOpen",
    skipFiles = { "<node_internals>/**", "node_modules/**" },
    sourceMaps = true,
    resolveSourceMapLocations = {
      "${workspaceFolder}/**",
      "!**/node_modules/**",
    },
    env = {
      NODE_ENV = "development",
    },
  },
  {
    name = "Launch API (yarn dev:local)",
    type = "pwa-node",
    request = "launch",
    runtimeExecutable = "yarn",
    runtimeArgs = { "dev:local" },
    rootPath = "${workspaceFolder}",
    cwd = "${workspaceFolder}",
    console = "integratedTerminal",
    internalConsoleOptions = "neverOpen",
    skipFiles = { "<node_internals>/**", "node_modules/**" },
    sourceMaps = true,
    resolveSourceMapLocations = {
      "${workspaceFolder}/**",
      "!**/node_modules/**",
    },
  },
  {
    name = "Attach to Process",
    type = "pwa-node",
    request = "attach",
    processId = require("dap.utils").pick_process,
    cwd = "${workspaceFolder}",
    skipFiles = { "<node_internals>/**" },
  },
  {
    name = "Attach to Port 9229",
    type = "pwa-node",
    request = "attach",
    port = 9229,
    cwd = "${workspaceFolder}",
    skipFiles = { "<node_internals>/**" },
  },
}

-- Also set up for JavaScript files
dap.configurations.javascript = dap.configurations.typescript
