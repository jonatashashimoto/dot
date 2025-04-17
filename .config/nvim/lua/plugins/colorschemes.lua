return {
  "drewtempelmeyer/palenight.vim",
  "sainnhe/edge",
  "sainnhe/sonokai",
  {
    "ellisonleao/gruvbox.nvim",
    config = function()
      local colors = require('gruvbox').palette
      require("gruvbox").setup({
        contrast = "hard", -- can be "hard", "soft" or empty string
        -- contrast = "",  -- can be "hard", "soft" or empty string
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          emphasis = true,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = true,
        invert_tabline = true,
        invert_intend_guides = true,
        inverse = true, -- invert background for search, diffs, statuslines
        dim_inactive = false,
        transparent_mode = false,
        overrides = {
          String = { fg = colors.bright_aqua },
          ["@method.call"] = { fg = colors.bright_yellow },
          ["@variable"] = { fg = colors.light0_soft },
        }

      })

      -- vim.cmd([[colorscheme gruvbox]])
      -- vim.cmd([[colorscheme tokyonight]])
      -- vim.cmd([[hi Normal guibg=NONE ctermbg=NONE]])
      -- vim.api.nvim_set_keymap('n', '<leader>tb', ':hi Normal guibg=NONE ctermbg=NONE<cr>', {})
      -- vim.cmd([[hi Folded guibg=#333333 ]])
    end
  },
  "folke/tokyonight.nvim",
  "wojciechkepka/bogster",
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      vim.cmd("colorscheme rose-pine")
      -- vim.api.nvim_set_keymap('n', '<leader>tb', ':hi Normal guibg=NONE ctermbg=NONE<cr>', {})
    end
  },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {
    'rebelot/kanagawa.nvim',
    name = 'kanagawa',
    config = function()
      -- vim.cmd("colorscheme kanagawa")
    end
  },
  {
    'sainnhe/everforest',
    config = function()
      vim.cmd [[ let g:everforest_background="hard" ]]
    end
  },
  {
    "nyoom-engineering/oxocarbon.nvim",
    -- Add in any other configuration;
    --   event = foo,
    --   config = bar
    --   end,
    config = function()
      -- vim.cmd([[colorscheme oxocarbon]])
      -- vim.cmd([[hi Normal guibg=NONE ctermbg=NONE]])
      -- vim.cmd([[hi Folded guibg=#333333 ]])
    end
  },
}
