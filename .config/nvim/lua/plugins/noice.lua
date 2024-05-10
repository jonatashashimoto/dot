return {
  "folke/noice.nvim",
  -- event = "VeryLazy",
  opts = {
    -- add any options here
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
  },
  config = function()
    require("notify").setup({
      background_colour = "#000000",
    })

    require("noice").setup({
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true,         -- use a classic bottom cmdline for search
        command_palette = true,       -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false,           -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false,       -- add a border to hover docs and signature help
      },
      messages = {
        -- NOTE: If you enable messages, then the cmdline is enabled automatically.
        -- This is a current Neovim limitation.
        enabled = false,             -- enables the Noice messages UI
        view = "notify",             -- default view for messages
        view_error = "notify",       -- view for errors
        view_warn = "notify",        -- view for warnings
        view_history = "messages",   -- view for :messages
        view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
      },
      notify = {
        -- Noice can be used as `vim.notify` so you can route any notification like other messages
        -- Notification messages have their level and other properties set.
        -- event is always "notify" and kind can be any log level as a string
        -- The default routes will forward notifications to nvim-notify
        -- Benefit of using Noice for this is the routing and consistent history view
        enabled = false,
        view = "notify",
      },
      cmdline = {
        enabled = true,     -- enables the Noice cmdline UI
        view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
        opts = {},          -- global options for the cmdline. See section on views
        ---@type table<string, CmdlineFormat>
        format = {
          -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
          -- view: (default is cmdline view)
          -- opts: any options passed to the view
          -- icon_hl_group: optional hl_group for the icon
          -- title: set to anything or empty string to hide
          cmdline = { pattern = "^:", icon = "", lang = "vim" },
          search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
          search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
          filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
          lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
          help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
          input = {}, -- Used by input()
          -- lua = false, -- to disable a format, set to `false`
        },
      },
    })

    vim.cmd [[highlight NoiceCmdlinePopupBorderCmdline        guifg=#666666]]
    vim.cmd [[highlight NoiceCmdlineIconCmdline               guifg=#cccccc]]
    vim.cmd [[highlight NoiceCmdlinePopupTitle                guifg=#cccccc]]
    vim.cmd [[highlight NoicePopupBorder                      guifg=#cccccc]]
    vim.cmd [[highlight NoicePopupmenuBorder                  guifg=#cccccc]] 
    vim.cmd [[highlight NoiceSplitBorder                      guifg=#cccccc]] 
    vim.cmd [[highlight NoiceConfirmBorder                    guifg=#cccccc]] 
    vim.cmd [[highlight NoiceCmdlinePopupBorder	              guifg=#cccccc]] 
    vim.cmd [[highlight NoiceCmdlinePopupBorderCalculator	    guifg=#cccccc]] 
    vim.cmd [[highlight NoiceCmdlinePopupBorderCmdline	       guifg=#cccccc]] 
    vim.cmd [[highlight NoiceCmdlinePopupBorderFilter	        guifg=#cccccc]] 
    vim.cmd [[highlight NoiceCmdlinePopupBorderHelp	          guifg=#cccccc]] 
    vim.cmd [[highlight NoiceCmdlinePopupBorderIncRename	     guifg=#cccccc]] 
    vim.cmd [[highlight NoiceCmdlinePopupBorderInput	         guifg=#cccccc]] 
    vim.cmd [[highlight NoiceCmdlinePopupBorderLua	           guifg=#cccccc]] 
    vim.cmd [[highlight NoiceCmdlinePopupBorderSearch         guifg=#cccccc]] 
 

  end
}
