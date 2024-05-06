return {

  -- telescope stuff
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-lua/popup.nvim" },
    { "nvim-lua/plenary.nvim" },
    { "tami5/sql.nvim" },
    { 'davvid/telescope-git-grep.nvim' }
  },
  config = function()

    require('telescope').load_extension('git_grep')

    local actions = require("telescope.actions")
    local themes = require "telescope.themes"
    local action_state = require("telescope.actions.state")

    require("telescope").setup({
      defaults = {
        theme = "center",
        mappings = {
          i = {
            -- ["<esc>"] = actions.close,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
          },
          n ={
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
          }
        },
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
        selection_caret = "> ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "descending",
        layout_strategy = "vertical",
        -- layout_strategy = "horizontal",
        -- layout_defaults = {
        --   horizontal = {
        --     mirror = false,
        --   },
        --   vertical = {
        --     mirror = false,
        --   },
        -- },
        layout_config = {
          horizontal = {
            width = 0.75,
          },
          vertical = {
            height = 0.95,
          },
          prompt_position = "bottom",
          -- prompt_prefix = "> ",
          preview_cutoff = 120,
          -- preview_cutoff = 1,
        },
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        file_ignore_patterns = {
          "%.pdf",
          "%.png",
          "%.jpeg",
          "%.jpg",
          "%.opus",
          "%.ogg",
          "%.mp3",
          "%.m4p",
          "%.ttf",
          "%.gz",
          "%.zip",
        },
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        -- shorten_path = true,
        path_display = { "smart" },
        winblend = 20,
        results_height = 1,
        results_width = 0.8,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        use_less = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
      },
      pickers = {
        oldfiles = {
          theme = "ivy",
        },
        buffers = {
          theme = "ivy",
        },
        vim_bookmarks = {
          initial_mode = "normal"
        },
        bookmarks = {
          theme = "ivy",
        }
      },

    })



    M = {}
    M.my_buffer = function()
      require("telescope.builtin").buffers({
        attach_mappings = function(prompt_bufnr, map)
          local delete_buf = function()
            local selection = action_state.get_selected_entry()
            actions.close(prompt_bufnr)
            vim.api.nvim_buf_delete(selection.bufnr, { force = true })
          end

          map("i", "<c-d>", delete_buf)
          return true
        end,
      })
    end

    vim.api.nvim_set_keymap("n", "<leader>b", ":lua M.my_buffer()<cr>", { noremap = true })

    local utils = require('telescope.utils')
    local builtin = require('telescope.builtin')

    M.project_files = function()
      local _, ret, _ = utils.get_os_command_output({ 'git', 'rev-parse', '--is-inside-work-tree' })
      if ret == 0 then
        builtin.git_files(require('telescope.themes').get_ivy({ winblend = 15 }))
      else
        builtin.find_files(require('telescope.themes').get_ivy({ winblend = 15 }))
      end
    end
    -- project_files()
    vim.cmd "autocmd User TelescopePreviewerLoaded setlocal number"

    vim.api.nvim_set_keymap("n", "<leader>mr", "<CMD>Telescope oldfiles<CR>", { noremap = true })
    vim.api.nvim_set_keymap("n", "<leader>b", "<CMD>Telescope buffers<CR>", { noremap = true })
    vim.api.nvim_set_keymap("n", "<leader>ps", "<CMD>Telescope live_grep<cr>", { noremap = true })
    vim.api.nvim_set_keymap("n", "<leader>pc", "<CMD>Telescope colorscheme<cr>", { noremap = true })
    vim.api.nvim_set_keymap("n", "<leader>pm", "<CMD>Telescope marks<cr>", { noremap = true })
    vim.api.nvim_set_keymap("n", "<leader>pf", ":lua M.project_files()<cr>", { noremap = true })

    SHOULD_RELOAD_TELESCOPE = true
    local reloader = function()
      if SHOULD_RELOAD_TELESCOPE then
        R "plenary"
        R "telescope"
        R "tj.telescope.setup"
      end
    end

    -- local actions = require "telescope.actions"
    -- local action_state = require "telescope.actions.state"

    local set_prompt_to_entry_value = function(prompt_bufnr)
      local entry = action_state.get_selected_entry()
      if not entry or not type(entry) == "table" then
        return
      end

      action_state.get_current_picker(prompt_bufnr):reset_prompt(entry.ordinal)
    end

    -- local M = {}
    vim.api.nvim_set_keymap("n", "<leader>pv", ":lua M.edit_neovim()<cr>", { noremap = true })
    -- vim.api.nvim_set_keymap("n", "/", ":lua M.curbuf()<cr>", { noremap = true })


    function M.edit_neovim()
      local opts_with_preview, opts_without_preview

      opts_with_preview = {
        prompt_title = "~ dotfiles ~",
        shorten_path = false,
        cwd = "~/dot/",
        hidden = true,

        -- search_dirs = { "~/", "~/.config/nvim/", "~/.config/alacritty/", "~/.config/skhd/", "~/.config/yabai/" },
        file_ignore_patterns = {
          "Library",
          "Desktop",
          "Documents",
          "DownloadsDocuments",
          ".meta",
        },

        layout_strategy = "flex",
        layout_config = {
          width = 0.9,
          height = 0.8,

          horizontal = {
            width = { padding = 0.15 },
          },
          vertical = {
            preview_height = 0.75,
          },
        },

        mappings = {
          i = {
            ["<C-y>"] = false,
          },
        },

        attach_mappings = function(_, map)
          map("i", "<c-y>", set_prompt_to_entry_value)
          map("i", "<M-c>", function(prompt_bufnr)
            actions.close(prompt_bufnr)
            vim.schedule(function()
              require("telescope.builtin").find_files(opts_without_preview)
            end)
          end)

          return true
        end,
      }

      opts_without_preview = vim.deepcopy(opts_with_preview)
      opts_without_preview.previewer = false

      require("telescope.builtin").find_files(opts_with_preview)
    end

    function M.find_nvim_source()
      require("telescope.builtin").find_files {
        prompt_title = "~ nvim ~",
        shorten_path = false,
        cwd = "~/build/neovim/",

        layout_strategy = "horizontal",
        layout_config = {
          preview_width = 0.35,
        },
      }
    end

    function M.edit_zsh()
      require("telescope.builtin").find_files {
        shorten_path = false,
        cwd = "~/.config/zsh/",
        prompt = "~ dotfiles ~",
        hidden = true,

        layout_strategy = "horizontal",
        layout_config = {
          preview_width = 0.55,
        },
        find_command = { 'rg', '--files', '--hidden', '-g', '!.git' },
      }
    end
  end
}
