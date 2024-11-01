return {
  "mikemcbride/telescope-mru.nvim",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  config = function()
    require("telescope").load_extension "mru_files"
    vim.keymap.set("n", "<leader>pr", function()
      require("telescope").extensions.mru_files.mru_files(
        require('telescope.themes').get_ivy({
          winblend = 20,
          path_display = { "smart" },
          shorten_path = false,
          layout_config = {
            height = 30
          },
        })
      )
    end)
  end
}
