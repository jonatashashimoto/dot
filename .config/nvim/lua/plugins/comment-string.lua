return {
  'JoosepAlviste/nvim-ts-context-commentstring',
  config = function()
    require('nvim-treesitter.configs').setup {
      enable_autocmd = false,
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
    }
  end
}
