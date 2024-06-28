return {
  'AndrewRadev/switch.vim',
  config = function()
    vim.api.nvim_set_keymap("n", "-", ":Switch<CR>", { noremap = true })
    vim.api.nvim_set_keymap("n", "<leader>-", ":e ~/.config/nvim/lua/plugins/switch.lua<CR>", { noremap = true })

    -- Samples
    -- \   switch#NormalizedCase(['one', 'two']),
    -- \   switch#Words(['three', 'four']),
    -- \   switch#NormalizedCaseWords(['five', 'six']),

    vim.cmd [[
 let g:switch_custom_definitions =
  \ [
  \   switch#NormalizedCase(['true', 'false']),
  \   switch#NormalizedCase(['on', 'off']),
  \   switch#NormalizedCase(['yes', 'no']),
  \   switch#NormalizedCase(['sim', 'não']),
  \   switch#NormalizedCase(['show', 'hide']),
  \   switch#NormalizedCase(['after', 'before']),
  \   switch#NormalizedCase(['next', 'previous']),
  \   [ "min", "max" ],
  \
  \
  \   [ "addClass", "removeClass" ],
  \   [ "GET", "POST", "PUT", "DELETE", "PATCH" ],
  \   [ "get", "set" ],
  \   [ "left", "right", "center" ],
  \   [ "width", "height" ],
  \   [ "error", "success", "warning" ],
  \   [ "padding", "margin" ],
  \   [ "top", "bottom" ],
  \   [ "relative", "absolute", "fixed", "static" ],
  \   [ "radio", "checkbox", "hidden" ],
  \
  \   [ "setTimeout", "setInterval" ],
  \   [ "console.log", "alert" ],
  \   [ "unshift", "push" ],
  \
  \   {
  \     '\<[a-z0-9]\+_\k\+\>': {
  \       '_\(.\)': '\U\1'
  \     },
  \     '\<[a-z0-9]\+[A-Z]\k\+\>': {
  \       '\([A-Z]\)': '_\l\1'
  \     },
  \   },
  \   {
  \     '\(import\)\(.*\)\(from\s\)\(.*\)': 'const\2= require(\4)',
  \     '\(const\|var\|let\)\(.*\)\(=.*require(\)\(.*\)\()\)': 'import\2from \4'
  \   },
  \   { 
  \     '- \[ \] \(.*\)': '- [x] \1',
  \     '- \[x\] \(.*\)': '- [ ] \1'
  \ },
  \ ]
]]

    -- vim.cmd [[ nnoremap <leader>1 yi":let @/ = @"<CR> ]]
  end
-- - [ ] hello

}
