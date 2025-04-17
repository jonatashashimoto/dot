return {
  "jghauser/auto-pandoc.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  ft = "markdown",
  config = function()
    vim.keymap.set("n", "<leader>pd", ':lua require("auto-pandoc").run_pandoc()' , { silent = true, buffer = 0 })
  end
}
