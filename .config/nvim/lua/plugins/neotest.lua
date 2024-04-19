return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    'nvim-neotest/neotest-jest',
  },
  config = function()
    require('neotest').setup({
      adapters = {
        -- require('neotest-jest')({
        --   jestCommand = "npm test --",
        --   -- jestConfigFile = "custom.jest.config.ts",
        --   env = { CI = true },
        --   cwd = function(path)
        --     return vim.fn.getcwd()
        --   end,
        -- }),

        require('neotest-jest')({
          jestCommand = "npm test --",
          -- jestConfigFile = "custom.jest.config.ts",
          env = { CI = true },
          cwd = function(path)
            return vim.fn.getcwd()
          end,
        }),
      }
    })
    vim.api.nvim_set_keymap("n", "<leader>tw",
      "<cmd>lua require('neotest').run.run({ jestCommand = 'jest --watch ' })<cr>", {})

    vim.api.nvim_set_keymap("n", "<leader>tt",
      "<cmd>lua require('neotest').run.run()<cr>", {})

    vim.api.nvim_set_keymap("n", "<leader>tq",
      "<cmd> lua require('neotest').output_panel.toggle()<cr>", {})


  end
}
