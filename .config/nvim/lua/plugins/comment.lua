return {
  {
    'echasnovski/mini.comment',
    event = "VeryLazy",
    dependencies = {
      {
        'JoosepAlviste/nvim-ts-context-commentstring',
        opts = {
          enable_autocmd = false,
        },
      },
    },
    config = function()
      -- Force a default commentstring for Svelte files so it NEVER returns empty
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "svelte",
        callback = function()
          vim.bo.commentstring = "<!-- %s -->"
        end,
      })

      require('mini.comment').setup({
        options = {
          custom_commentstring = function()
            local ok, ts_internal = pcall(require, 'ts_context_commentstring.internal')
            if not ok then
              return vim.bo.commentstring
            end

            -- Get the context-aware comment string from tree-sitter
            local ts_comment = ts_internal.calculate_commentstring()
            if type(ts_comment) == "string" and ts_comment ~= "" then
              return ts_comment
            end

            -- Fallback to the buffer's default comment string
            return vim.bo.commentstring
          end,
        },
      })
    end,
  },
}
