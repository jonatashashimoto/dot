return {
  "chrisgrieser/nvim-various-textobjs",
  lazy = false,
  config = function()
    require('various-textobjs').setup({
      useDefaultKeymaps = true,
      disabledKeymaps = { "gc" },

    })
  end
}
