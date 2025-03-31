return {
  "tomasky/bookmarks.nvim",
  -- Name = "tomasky/bookmarks.nvim",
  -- dir = "~/.config/nvim/bookmarks.nvim",
  -- dev = true,
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    require('bookmarks').setup({
      -- sign_priority = 8,  --set bookmark sign priority to cover other sign
      save_file = vim.fn.expand "$HOME/.bookmark", -- bookmarks save file path
      keywords = {
        ["@t"] = "✪ ", -- mark annotation startswith @t ,signs this icon as `Todo`
        ["@w"] = "⚠ ", -- mark annotation startswith @w ,signs this icon as `Warn`
        ["@f"] = "☢ ", -- mark annotation startswith @f ,signs this icon as `Fix`
        ["@n"] = "✎ ", -- mark annotation startswith @n ,signs this icon as `Note`
      },
      on_attach = function()
        local bm = require "bookmarks"
        local map = vim.keymap.set
        map("n", "mm", bm.bookmark_toggle)    -- add or remove bookmark at current line
        map("n", "mi", bm.bookmark_ann)       -- add or edit mark annotation at current line
        map("n", "mc", bm.bookmark_clean)     -- clean all marks in local buffer
        map("n", "mn", bm.bookmark_next)      -- jump to next mark in local buffer
        map("n", "mp", bm.bookmark_prev)      -- jump to previous mark in local buffer
        map("n", "ml", bm.bookmark_list)      -- show marked file list in quickfix window
        map("n", "mx", bm.bookmark_clear_all) -- add or remove bookmark at current line
      end
    })

    require('telescope').load_extension('bookmarks')
    local map = vim.keymap.set
    map("n", "ma", ':Telescope bookmarks list<cr>') -- add or remove bookmark at current line


    local autocmd = vim.api.nvim_create_autocmd -- Create autocommand
    function dump(o)
      if type(o) == 'table' then
        local s = '{ '
        for k, v in pairs(o) do
          if type(k) ~= 'number' then k = '"' .. k .. '"' end
          s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
        end
        return s .. '} '
      else
        return tostring(o)
      end
    end

    -- make buffer close when accessing bookmark item
    -- https://github.com/tomasky/bookmarks.nvim/issues/24
    local paths = {}
    autocmd('User', {
      pattern = 'BookmarkSetQuickfix',
      callback = function(args)
        for _, value in pairs(args.data) do
          table.insert(paths, value.filename)
        end
      end
    })
    autocmd('BufEnter', {
      callback = function()
        local function includes_any(str, substrings)
          for _, substr in ipairs(substrings) do
            if string.find(str, substr, 1, true) then
              return true
            end
          end
          return false
        end
        if (includes_any(vim.api.nvim_buf_get_name(0), paths)) then
          paths = {}
          vim.api.nvim_command('copen')
          vim.api.nvim_command("bd")
        end
      end
    })
  end
}
