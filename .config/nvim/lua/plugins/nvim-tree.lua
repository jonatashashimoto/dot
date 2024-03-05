return {
  "kyazdani42/nvim-tree.lua",
  dependencies = {
    "kyazdani42/nvim-web-devicons",
  },
  config = function()
    vim.api.nvim_set_keymap("n", "<leader><tab>", ":NvimTreeToggle ./<cr>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>f", ":NvimTreeFindFile<cr>", { noremap = true, silent = true })
    vim.cmd([[ autocmd FileType NvimTree nnoremap <buffer> <leader>q :NvimTreeClose<cr> ]])

    vim.api.nvim_create_autocmd("BufLeave", {
      callback = function(arg)
        -- print(vim.api.nvim_buf_get_name(0))
        if vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
          -- vim.cmd "echo 'HELLO'"
          vim.cmd "quit"
        end
      end
    })

    local function my_on_attach(bufnr)
      local api = require "nvim-tree.api"

      local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      -- default mappings
      api.config.mappings.default_on_attach(bufnr)

      -- custom mappings
      vim.keymap.set('n', 'u', api.tree.change_root_to_parent, opts('Up'))
      vim.keymap.set('n', 'C', api.tree.change_root_to_node, opts('Up'))
      vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
    end

    -- disable netrw at the very start of your init.lua
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- set termguicolors to enable highlight groups
    vim.opt.termguicolors = true

    -- OR setup with some options
    require("nvim-tree").setup({
      sort_by = "case_sensitive",
      view = {
        width = 35,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = true,
      },
      on_attach = my_on_attach,
      actions = {
        open_file = {
          quit_on_open = true,
        },
      },
    })
  end
}
