local M = {}
local cmd = vim.cmd
local api = vim.api
local types = {o = vim.o, b = vim.bo, w = vim.wo}

-- Get table length
function M.length(table)
  local count = 0
  for _ in ipairs(table) do count = count + 1 end
  return count
end

function M.UnloadAllModules()
  -- Lua patterns for the modules to unload
  local unload_modules = {
    --'^mappings$',
    '^options$',
    --'^statusline$',
    '^plugins$',
    '^plugins_config$',
    '^utils$'
  }

  for k,_ in pairs(package.loaded) do
    for _,v in ipairs(unload_modules) do
      if k:match(v) then
        package.loaded[k] = nil
        break
      end
    end
  end
end

-- Reload Vim configuration
function M.Reload()
  -- Stop LSP
  cmd('LspStop')

  -- Unload all already loaded modules
  M.UnloadAllModules()

  -- Source init.lua
  cmd('luafile $MYVIMRC')
end

-- Restart Vim without having to close and run again
function M.Restart()
  -- Reload config
  M.Reload()

  -- Manually run VimEnter autocmd to emulate a new run of Vim
  cmd('doautocmd VimEnter')
end

-- Get option
function M.get_opt(type, name)
  return types[type][name]
end

-- Set option
function M.set_opt(type, name, value)
  types[type][name] = value

  if type ~= 'o' then
    types['o'][name] = value
  end
end

-- Append option to a list of options
function M.append_opt(type, name, value)
  local current_value = M.get_opt(type, name)

  if not string.match(current_value, value) then
    M.set_opt(type, name, current_value .. value)
  end
end

-- Remove option from a list of options
function M.remove_opt(type, name, value)
  local current_value = M.get_opt(type, name)

  if string.match(current_value, value) then
    M.set_opt(type, name, string.gsub(current_value, value, ""))
  end
end

-- Create an augroup
function M.create_augroup(autocmds, name)
  cmd('augroup ' .. name)
  cmd('autocmd!')

  for _, autocmd in ipairs(autocmds) do
    cmd('autocmd ' .. table.concat(autocmd, ' '))
  end

  cmd('augroup END')
end

function M.nvim_create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    api.nvim_command('augroup '..group_name)
    api.nvim_command('autocmd!')
    for _, def in ipairs(definition) do
      -- if type(def) == 'table' and type(def[#def]) == 'function' then
      -- 	def[#def] = lua_callback(def[#def])
      -- end
      local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
      api.nvim_command(command)
    end
    api.nvim_command('augroup END')
  end
end


function M.is_buffer_empty()
    -- Check whether the current buffer is empty
    return vim.fn.empty(vim.fn.expand('%:t')) == 1
end

function M.has_width_gt(cols)
    -- Check if the windows width is greater than a given number of columns
    return vim.fn.winwidth(0) / 2 > cols
end

return M
