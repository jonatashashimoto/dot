return {
  "aznhe21/hop.nvim",
  config = function()
    -- you can configure Hop the way you like here; see :h hop-config
    require("hop").setup({
      keys = "etovxqpdygfblzhckisuran",
      create_hl_autocmd = true,
      uppercase_labels = false,
      -- hint_offset = 1,
      -- hint_position = require'hop.hint'.HintPosition.END,
    })
    -- vim.api.nvim_set_keymap("n", "f", ":HopWordAC<cr>", { noremap = true, silent = false })
    -- vim.api.nvim_set_keymap("n", "F", ":HopWordBC<cr>", { noremap = true, silent = false })
    --
    -- vim.api.nvim_set_keymap("n", "t", ":HopChar1<cr>", { noremap = true, silent = false })
    -- vim.api.nvim_set_keymap("o", "t", "v:HopChar1<cr>", { noremap = true, silent = false })

    vim.api.nvim_set_keymap("n", "s", ":HopWordMW<cr>", { noremap = true, silent = false })

    -- local hop = require('hop')
    -- local directions = require('hop.hint').HintDirection
    -- vim.keymap.set('', 'f', function()
    --   hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
    -- end, { remap = true })
    -- vim.keymap.set('', 'F', function()
    --   hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
    -- end, { remap = true })
    -- vim.keymap.set('', 't', function()
    --   hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
    -- end, { remap = true })
    -- vim.keymap.set('', 'T', function()
    --   hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
    -- end, { remap = true })
  end
}
