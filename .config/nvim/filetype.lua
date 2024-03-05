vim.filetype.add({
  filename = {
    [".git/config"] = "gitconfig",
    ["~/.config/mutt/muttrc"] = "muttrc",
    ["README$"] = function(path, bufnr)
      print('enttrou no README')
      if string.find("#", vim.api.nvim_buf_get_lines(bufnr, 0, 1, true)) then
        return "markdown"
      end

      -- no return means the filetype won't be set and to try the next method
    end,
  },
})
