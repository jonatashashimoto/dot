return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" },
  opts = {
    -- Move everything into opts and remove the config function entirely
    -- This ensures lazy.nvim merges everything correctly
    exclude = {
      buftypes = { "nofile", "terminal", "prompt" },
      filetypes = { "snacks_picker_input", "snacks_picker_preview", "snacks_picker_list" },
    },
    anti_conceal = { enabled = false },
    bullets = { "‧", "○", "◆", "◇" },
    -- This stops the plugin from even TRYING to parse during the picker phase
    enabled = true,
    max_file_size = 0.1, -- 100KB
  },
  -- REMOVE the config = function() ... end block. 
  -- Lazy.nvim will call setup(opts) automatically.
}
