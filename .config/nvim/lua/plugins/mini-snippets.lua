return {
  'echasnovski/mini.snippets',
  version = false,
  config = function()
    local gen_loader = require('mini.snippets').gen_loader
    require('mini.snippets').setup({
      -- Array of snippets and loaders (see |MiniSnippets.config| for details).
      -- Nothing is defined by default. Add manually to have snippets to match.
      snippets = {
        -- Load custom file with global snippets first (adjust for Windows)
        gen_loader.from_file('~/.config/nvim/snippets/global.json'),

        -- Load snippets based on current language by reading files from
        -- "snippets/" subdirectories from 'runtimepath' directories.
        gen_loader.from_lang(),
      },

      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        -- Expand snippet at cursor position. Created globally in Insert mode.
        expand = '<C-l>',

        -- Interact with default `expand.insert` session.
        -- Created for the duration of active session(s)
        jump_next = '<C-l>',
        jump_prev = '<C-h>',
        stop = '<C-c>',
      },

      -- Functions describing snippet expansion. If `nil`, default values
      -- are `MiniSnippets.default_<field>()`.
      expand = {
        -- Resolve raw config snippets at context
        prepare = nil,
        -- Match resolved snippets at cursor position
        match = nil,
        -- Possibly choose among matched snippets
        select = nil,
        -- Insert selected snippet
        insert = nil,
      },
    })
  end
}
