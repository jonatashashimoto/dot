local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

-- local function dump(o)
--   if type(o) == 'table' then
--     local s = '{ '
--     for k, v in pairs(o) do
--       if type(k) ~= 'number' then k = '"' .. k .. '"' end
--       s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
--     end
--     return s .. '} '
--   else
--     return tostring(o)
--   end
-- end

Custom_commands = function(opts)
  opts = opts or {}

  local result = pickers.new(opts, {
    prompt_title = "My Commands",
    winblend = 20,
    theme = 'ivy',
    finder = finders.new_table {
      results = {
        { "Gerar CEP", "cep" },
        { "Gerar CPF",  "cpf" },
        { "Gerar CNPJ", "cnpj" },
        { "Gerar RG", "rg" },
        { "Gerar PISPASEP", "pispasep" },
        -- { "bloow", "#0000ff" },
      },
      entry_maker = function(entry)
        return {
          value = entry[2],
          display = entry[1],
          ordinal = entry[1],
        }
      end
    },
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        -- print(dump(selection))
        -- print((selection.value))
        vim.cmd("let @+ = system('node '.stdpath(\"config\").'/myPlugins/plugin/node/gerador/" ..
          selection.value .. ".js')")
      end)
      return true
    end,
    sorter = conf.generic_sorter(opts),
  }):find()
end

vim.api.nvim_set_keymap('n', '<leader><leader>p', ":lua Custom_commands(require('telescope.themes').get_cursor{})<cr>", { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>pp', ":lua Custom_commands(require('telescope.themes').get_cursor{})<cr>", { noremap = true })
