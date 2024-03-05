return {
  {
    'ThePrimeagen/harpoon',
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")

      harpoon:setup()
      -- harpoon:setup({
      --     -- Setting up custom behavior for a list named "cmd"
      --     "cmd" = {
      --         -- When you call list:append() this function is called and the return
      --         -- value will be put in the list at the end.
      --         --
      --         -- which means same behavior for prepend except where in the list the
      --         -- return value is added
      --         --
      --         -- @param possible_value string only passed in when you alter the ui manual
      --         add = function(possible_value)
      --             -- get the current line idx
      --             local idx = vim.fn.line(".")
      --
      --             -- read the current line
      --             local cmd = vim.api.nvim_buf_get_lines(0, idx - 1, idx, false)[1]
      --             if cmd == nil then
      --                 return nil
      --             end
      --
      --             return {
      --                 value = cmd,
      --                 context = { ... any data you want ... },
      --             }
      --         end,
      --
      --         --- This function gets invoked with the options being passed in from
      --         --- list:select(index, <...options...>)
      --         --- @param list_item {value: any, context: any}
      --         --- @param list { ... }
      --         --- @param option any
      --         select = function(list_item, list, option)
      --             -- WOAH, IS THIS HTMX LEVEL XSS ATTACK??
      --             vim.cmd(list_item.value)
      --         end
      --
      --     }
      -- })          k

      -- vim.api.nvim_set_keymap("n", "<leader>h", ':lua require("harpoon.mark").add_file()<cr>', { noremap = true, silent = false })
      -- vim.api.nvim_set_keymap("n", "<leader><cr>", ':lua require("harpoon.ui").toggle_quick_menu()<cr>', { noremap = true, silent = false })
      -- vim.api.nvim_set_keymap("n", "<leader>]", ':lua require("harpoon.ui").nav_next()<cr>', { noremap = true, silent = false })
      -- vim.api.nvim_set_keymap("n", "<leader>[", ':lua require("harpoon.ui").nav_prev()<cr>', { noremap = true, silent = false })
      -- vim.api.nvim_set_keymap("n", "<leader>1", ':lua require("harpoon.ui").nav_file(1)<cr>', { noremap = true, silent = false })
      -- vim.api.nvim_set_keymap("n", "<leader>2", ':lua require("harpoon.ui").nav_file(2)<cr>', { noremap = true, silent = false })
      -- vim.api.nvim_set_keymap("n", "<leader>3", ':lua require("harpoon.ui").nav_file(3)<cr>', { noremap = true, silent = false })
      -- vim.api.nvim_set_keymap("n", "<leader>4", ':lua require("harpoon.ui").nav_file(4)<cr>', { noremap = true, silent = false })


      vim.keymap.set("n", "<leader>h", function() harpoon:list():append() end)
      vim.keymap.set("n", "<leader><enter>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

      vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
      vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
      vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
      vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)
    end
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  },

}
