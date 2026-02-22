return {
  "HakonHarnes/img-clip.nvim",
  event = "VeryLazy",
  opts = {
    -- add options here
    -- or leave it empty to use the default settings
    dir_path = function()
      return vim.fn.expand("%:t:r")
    end,
  },
  keys = {
    -- suggested keymap
    { "<leader><leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
  },
}
