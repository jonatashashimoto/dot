local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

Custom_commands = function(opts)
  opts = opts or {}

  local result = pickers.new(opts, {
    prompt_title = "My Commands",
    winblend = 20,
    theme = 'ivy',
    finder = finders.new_table {
      results = {
        { "Gerar CEP",      "cep" },
        { "Gerar CPF",      "cpf" },
        { "Gerar CNPJ",     "cnpj" },
        { "Gerar RG",       "rg" },
        { "Gerar PISPASEP", "pispasep" },
        { "Formatar JSON",  "jsonFormat" },
        { "bloow", "#0000ff" },
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
        local function isGenerator(armyName)
          return string.match(armyName, "^Gerar") ~= nil
        end

        if (isGenerator(selection.display)) then
          local config_path = vim.fn.stdpath('config')
          local command = "node " .. config_path .. "/myPlugins/plugin/node/gerador/" .. selection.value .. ".js"

          local handle = io.popen(command)
          local result = handle:read("*a")
          handle:close()

          -- Adds to clipboard
          vim.cmd("let @+ = " .. result)

          local pos = vim.api.nvim_win_get_cursor(0)[2]
          local line = vim.api.nvim_get_current_line()
          local nline = line:sub(0, pos) .. result:gsub('\n', '') .. line:sub(pos + 1)
          vim.api.nvim_set_current_line(nline)
        else

          function M.get_selection()
            -- does not handle rectangular selection
            local s_start = vim.fn.getpos("'<")
            local s_end = vim.fn.getpos("'>")
            local n_lines = math.abs(s_end[2] - s_start[2]) + 1
            local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
            lines[1] = string.sub(lines[1], s_start[3], -1)
            if n_lines == 1 then
              lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
            else
              lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
            end
            return lines
          end

          print(M.get_selection())

        end
        -- print((selection.value))
      end)
      return true
    end,
    sorter = conf.generic_sorter(opts),
  }):find()
end

vim.api.nvim_set_keymap('n', '<leader><leader>p', ":lua Custom_commands(require('telescope.themes').get_cursor{})<cr>",
  { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>pp', ":lua Custom_commands(require('telescope.themes').get_cursor{})<cr>",
  { noremap = true })

vim.api.nvim_set_keymap('v', '<leader>pp', ":lua Custom_commands(require('telescope.themes').get_cursor{})<cr>",
  { noremap = true })

vim.api.nvim_set_keymap('v', '<leader><leader>p', ":lua Custom_commands(require('telescope.themes').get_cursor{})<cr>",
  { noremap = true })
