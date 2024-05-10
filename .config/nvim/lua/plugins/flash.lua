return {
 'folke/flash.nvim',
  config = function ()
    require('flash').setup()
    vim.cmd [[highlight FlashBackdrop guifg=#cccccc]] 
    vim.cmd [[highlight FlashLabel guibg=#00cc00 guifg=#ffffff]] 
    vim.api.nvim_set_keymap(
      "n",
      "s",
      "/",
      { noremap = true, silent = true }
    )
  end
}
