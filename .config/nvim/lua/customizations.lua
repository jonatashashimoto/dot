local telescope = require 'telescope'
local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'

local commands = {
  {
    name = 'Organize imports',
    category = "LS",
    action = function()
      vim.fn.CocActionAsync('runCommand', 'editor.action.organizeImport')
    end
  },
  {
    name = 'Format document',
    category = "LS",
    action = function()
      vim.fn.CocActionAsync('runCommand', 'editor.action.formatDocument')
    end
  },
  {
    name = 'Run Pandoc',
    category = "Pandoc",
    action = function() require("auto-pandoc").run_pandoc() end
  },
  {
    name = 'Git Difftool',
    category = "Git",
    action = function() vim.cmd('Git difftool') end
  },
}

local longest_command_name = 0
for _, command in ipairs(commands) do
  if #command.name > longest_command_name then
    longest_command_name = #command.name
  end
end

local entry_display = require 'telescope.pickers.entry_display'
local displayer = entry_display.create {
  separator = " ",
  items = {
    { width = longest_command_name + 2 },
    -- The final column can be set to fill the remaining space
    { remaining = true },
  },
}
local finder = finders.new_table {
  results = commands,
  entry_maker = function(entry)
    return {
      value = entry,
      display = function(ent)
        return displayer {
          ent.value.name,
          { ent.value.category, "TelescopeResultsComment" }
        }
      end,
      ordinal = entry.name,
    }
  end,
}
