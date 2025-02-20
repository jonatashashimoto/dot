return {

  {
    'williamboman/mason.nvim',
    config = function()
      require("mason").setup({
        PATH = "prepend", -- "skip" seems to cause the spawning error
      })
    end
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = {
          "lua_ls",
          -- 'eslint-lsp',
          -- 'js-debug-adapter',
          -- 'prettier',
          'ts_ls',

          -- svelte-language-server svelte (keywords: svelte)
          -- fixjson (keywords: json)
          -- json-lsp jsonls (keywords: json)
          -- jsonlint (keywords: json)
          -- lemminx (keywords: xml)
          -- lua-language-server lua_ls (keywords: lua)
          -- prettier (keywords: angular, css, flow, graphql, html, json, jsx, javascript, less, markdown, scss, typescript, vue, yaml)
          -- tailwindcss-language-server tailwindcss (keywords: css)
          -- typescript-language-server ts_ls (keywords: typescript, javascript)
          -- vue-language-server volar (keywords: vue)
          -- xmlformatter (keywords: xml)
        }
      }
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      local on_attach = function(_, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        -- vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
        -- vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
        vim.keymap.set("n", "gi", vim.lsp.buf.incoming_calls, bufopts)
        vim.keymap.set("n", "<k-k>", vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
        vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set("n", "<leader>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)
        vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
        vim.keymap.set("n", "Q", function()
          vim.lsp.buf.format({ async = true })
        end, bufopts)


        vim.keymap.set("i", "<C-n>", vim.lsp.buf.hover, bufopts)
        vim.keymap.set("i", "<C-p>", vim.lsp.buf.hover, bufopts)
      end

      on_attach()

      lspconfig.ts_ls.setup({
        autostart = true,
        on_attach = on_attach,
        -- capabilities = {},

        -- cmd = {'typescript-language-server', '--stdio'},
        -- root_dir = lspconfig.util.root_pattern("tsconfig.json", "package.json", ".git"),
        root_dir = function(pattern)
          local cwd  = vim.loop.cwd();
          local root = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git")(pattern);
          return root or cwd;
        end,
        init_options = {
          preferences = {
            -- disableSuggestions = true,
            provideFormatter = true,
          },
        },
      })
      lspconfig.jsonls.setup({
        on_attach = on_attach,
        filetypes = { 'json' },
        init_options = {
          provideFormatter = true,
        },
      })
      lspconfig.volar.setup({
        on_attach = on_attach,
        filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
        init_options = {
          provideFormatter = true,
        },
      })
      lspconfig.vuels.setup({
        on_attach = on_attach,
        init_options = {
          provideFormatter = true,
        },
      })
      lspconfig.pyright.setup({
        on_attach = on_attach,
      })
      lspconfig.svelte.setup({
        on_attach = on_attach,
      })
      lspconfig.tailwindcss.setup({
        on_attach = on_attach,
      })
      lspconfig.gopls.setup({
        on_attach = on_attach,
      })
      lspconfig.golangci_lint_ls.setup({
        on_attach = on_attach,
      })

      -- example to setup lua_ls and enable call snippets
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace"
            }
          }
        }
      })

      lspconfig.lua_ls.setup {
        settings = {
          Lua = {
            -- runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            -- version = 'LuaJIT',
            -- },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = {
                'vim',
                'require'
              },
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
              enable = true,
            },
          },
        },
      }
      lspconfig.emmet_language_server.setup({
        filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "pug", "typescriptreact", "svelte", "vue" },
        -- Read more about this options in the [vscode docs](https://code.visualstudio.com/docs/editor/emmet#_emmet-configuration).
        -- **Note:** only the options listed in the table are supported.
        init_options = {
          ---@type table<string, string>
          includeLanguages = {},
          --- @type string[]
          excludeLanguages = {},
          --- @type string[]
          extensionsPath = {},
          --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
          preferences = {},
          --- @type boolean Defaults to `true`
          showAbbreviationSuggestions = true,
          --- @type "always" | "never" Defaults to `"always"`
          showExpandedAbbreviation = "always",
          --- @type boolean Defaults to `false`
          showSuggestionsAsSnippets = false,
          --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
          syntaxProfiles = {},
          --- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
          variables = {},
        },
      })
    end
  }
}
