local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins", {
  dev = {
    -- directory where you store your local plugin projects
    path = "~/.config/nvim/",
    ---@type string[] plugins that match these patterns will use your local
    patterns = {},    -- For example {"folke"}
    fallback = false, -- Fallback to git when local plugin doesn't exist
  },
})
