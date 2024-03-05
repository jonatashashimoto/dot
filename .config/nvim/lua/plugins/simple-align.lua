return {
  "kg8m/vim-simple-align",
  config = function()
    vim.api.nvim_set_keymap("v", "aa", ":SimpleAlign ", { noremap = true, silent = false })
    vim.api.nvim_set_keymap(
      "v",
      "ah",
      ":SimpleAlign  -j left<left><left><left><left><left><left><left><left>",
      { noremap = true, silent = false }
    )
    vim.api.nvim_set_keymap(
      "v",
      "al",
      ":SimpleAlign  -j right<left><left><left><left><left><left><left><left><left>",
      { noremap = true, silent = false }
    )
  end
}
