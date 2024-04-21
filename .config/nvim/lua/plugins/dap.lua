return {
  {
    "mfussenegger/nvim-dap",
    -- lazy = true,
    dependencies = {
      'nvim-neotest/nvim-nio',
      "rcarriga/nvim-dap-ui",
      {
        "microsoft/vscode-js-debug",
        -- After install, build it and rename the dist directory to out
        build = "npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out",
        version = "1.*",
      },
      {
        "mxsdev/nvim-dap-vscode-js",
        config = function()
          ---@diagnostic disable-next-line: missing-fields
          require("dap-vscode-js").setup({
            -- Path of node executable. Defaults to $NODE_PATH, and then "node"
            -- node_path = "node",

            -- Path to vscode-js-debug installation.
            debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"),

            -- Command to use to launch the debug server. Takes precedence over "node_path" and "debugger_path"
            -- debugger_cmd = { "js-debug-adapter" },

            -- which adapters to register in nvim-dap
            adapters = {
              "chrome",
              "pwa-node",
              "pwa-chrome",
              "pwa-msedge",
              "pwa-extensionHost",
              "node-terminal",
            },

            -- Path for file logging
            -- log_file_path = "(stdpath cache)/dap_vscode_js.log",

            -- Logging level for output to file. Set to false to disable logging.
            -- log_file_level = false,

            -- Logging level for output to console. Set to false to disable console output.
            -- log_console_level = vim.log.levels.ERROR,
          })
        end,
      },
    },

    config = function()
      local dap = require('dap')

      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}", --let both ports be the same for now...
        executable = {
          command = "node",
          -- -- 💀 Make sure to update this path to point to your installation
          args = { vim.fn.stdpath('data') .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js", "${port}" },
          -- command = "js-debug-adapter",
          -- args = { "${port}" },
        },
      }

      for _, language in ipairs({ "typescript", "javascript" }) do
        dap.configurations[language] = {
          {
            type = 'pwa-node',
            request = 'launch',
            name = 'Launch Current File (pwa-node)',
            cwd = "${workspaceFolder}", -- vim.fn.getcwd(),
            args = { '${file}' },
            sourceMaps = true,
            protocol = 'inspector',
          },
          {
            type = 'pwa-node',
            request = 'launch',
            name = 'Launch Current File (Typescript)',
            cwd = "${workspaceFolder}",
            -- program = "${file}",
            runtimeExecutable = 'ts-node-dev',
            runtimeArgs = { '--respawn', '--loader', '--loader=ts-node/esm' },
            args = { '${file}' },
            sourceMaps = true,
            protocol = 'inspector',
            -- outFiles = { "${workspaceFolder}/**/**/*", "!**/node_modules/**" },
            skipFiles = { '<node_internals>/**', 'node_modules/**' },
            resolveSourceMapLocations = {
              "${workspaceFolder}/**",
              "!**/node_modules/**",
            },
          },
          {
            type = 'pwa-node',
            request = 'attach',
            name = 'Auto Attach(pwa-node)',
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
            skipFiles = { '<node_internals>/**' },
          },
        }
      end

      vim.api.nvim_set_keymap('n', '<F5>', ":lua require'dap'.continue()", {})
      vim.api.nvim_set_keymap('n', '<F10>', ":lua require'dap'.step_over()<cr>", {})
      vim.api.nvim_set_keymap('n', '<F11>', ":lua require'dap'.step_into()<cr>", {})
      vim.api.nvim_set_keymap('n', '<F12>', ":lua require'dap'.step_out()<cr>", {})
      vim.api.nvim_set_keymap('n', '<leader><leader>b', ":lua require'dap'.toggle_breakpoint()<cr>", {})

      require('dapui').setup({})

      -- require("dap-vscode-js").setup({
      --   debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
      --   adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
      -- })


      require("dapui").setup()
      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({ reset = true })
      end
      dap.listeners.before.event_terminated["dapui_config"] = dapui.close
      dap.listeners.before.event_exited["dapui_config"] = dapui.close
    end
  },
  {
    "mxsdev/nvim-dap-vscode-js",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require('dap-vscode-js').setup({
        debugger_path = '~/.local/share/nvim/lazy/vscode-js-debug',
      })
    end
  },
  {
    "microsoft/vscode-js-debug",
    build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
  },
  {
    "rcarriga/nvim-dap-ui",
  },
  "theHamsta/nvim-dap-virtual-text",
  "nvim-telescope/telescope-dap.nvim",

}
