return {
  "ntk148v/yankdown.nvim",
  opts = {},  -- calls setup() automatically
  config = function(_, opts)
    require("yankdown").setup({
      auto_intercept = true,  -- override p/P in Markdown buffers
      notify = true,           -- warn once on paste fallback/conversion failure
      check = "lazy",          -- cache dependency check on first Markdown paste
    })
  end
}
