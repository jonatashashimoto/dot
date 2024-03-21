return {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  config = function()
    -- local config_path = vim.fn.stdpath('config')
    vim.api.nvim_set_keymap(
      "n",
      "<leader>nt",
      ":Telescope file_browser path=~/GDrive/_NOTAS/obsidian select_buffer=true<CR>",
      { noremap = true }
    )

    local fb_actions = require "telescope".extensions.file_browser.actions
    require("telescope").setup {
      extensions = {
        file_browser = {
          theme = "ivy",
          -- disables netrw and use telescope-file-browser in its place
          -- hijack_netrw = true,
          mappings = {
            ["i"] = {
              ["<C-h>"] = fb_actions.goto_home_dir,
              ["<C-i>"] = fb_actions.create,
              ["<C-r>"] = fb_actions.rename,
              ["<C-x>"] = fb_actions.move,
              ["<C-u>"] = fb_actions.goto_parent_dir,
              -- your custom insert mode mappings
            },
            ["n"] = {
              ["<C-h>"] = fb_actions.goto_home_dir,
              ["<C-i>"] = fb_actions.create,
              ["<C-r>"] = fb_actions.rename,
              ["<C-x>"] = fb_actions.move,
              ["<C-u>"] = fb_actions.goto_parent_dir,
              -- your custom normal mode mappings
            },
          },
        },
      },
    }

    require("telescope").load_extension "file_browser"
  end
}
