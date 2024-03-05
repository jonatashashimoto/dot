return {
  "mbbill/undotree",
  config = function()
    vim.api.nvim_set_keymap(
      "n",
      "<leader><leader>u",
      ":UndotreeToggle<cr>",
      { noremap = true, silent = true }
    )
  end

}
