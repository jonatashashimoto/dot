return {
  "benmills/vimux",
  config = function()
    local bind = vim.api.nvim_set_keymap

    -- bind('', '<leader>nt', ':call VimuxRunCommand("clear; npm test")<CR>', {})
    bind('', '<leader>x', ':VimuxPromptCommand<cr>', {})

    -- map <leader>nt :call VimuxRunCommand("clear; npm test")<CR>
    -- map <leader>x :VimuxPromptCommand<CR>
  end
}
