return {
  "nvim-neorg/neorg",
  build = ":Neorg sync-parsers",
  opts = {
    load = {
      ["core.defaults"] = {},
      ["core.integrations.telescope"] = {},
    },
  },
  dependencies = { { "nvim-lua/plenary.nvim" }, { "nvim-neorg/neorg-telescope" } },
  config = function()
    local neorg_callbacks = require("neorg.core.callbacks")
    require("neorg").setup {
      load = {
        ["core.defaults"] = {},    -- Loads default behaviour
        ["core.concealer"] = {},   -- Adds pretty icons to your documents
        ["core.dirman"] = {        -- Manages Neorg workspaces
          config = {
            workspaces = {
              notes = "~/GDrive/_NOTAS/neorg",
            },
          },
        },
      },
    }
    vim.api.nvim_set_keymap("n", "<leader>nt", ":Neorg workspace notes<cr>", {})

    neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
      -- Map all the below keybinds only when the "norg" mode is active
      keybinds.map_event_to_mode("norg", {
        n = { -- Bind keys in normal mode
          { "<C-s>", "core.integrations.telescope.find_linkable" },
        },

        i = { -- Bind in insert mode
          { "<C-l>", "core.integrations.telescope.insert_link" },
        },
      }, {
        silent = true,
        noremap = true,
      })
    end)
  end
}
