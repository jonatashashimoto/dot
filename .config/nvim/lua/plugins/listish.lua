return {
  "arsham/listish.nvim",
  dependencies = {
    "arsham/arshlib.nvim",
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  config = function()
    require("listish").config({})
  end,
}
