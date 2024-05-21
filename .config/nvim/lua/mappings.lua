local bind = vim.api.nvim_set_keymap

-- smart curly braces enter (indents it properly)
vim.cmd [[ inoremap <expr> <cr> getline(".")[col(".")-2:col(".")-1]=="{}" ? "<cr><esc>O" : "<cr>" ]]

bind("n", "<leader>so", ":so %<cr>", { noremap = true, silent = false })
-- bind("n", "<leader>nt", ":e ~/GDrive/AOOP/boti/logs<cr>", {noremap = true})

-- nnoremap ; :
bind("n", ";", ":", { noremap = true })

-- "removes trailing spaces and indent
-- vim.cmd([[ nnoremap Q gg=G``zz <esc> :%s/\s\+$//e<esc>:echo ""<esc>``zz ]])
bind("n", "Q", ':lua vim.lsp.buf.format()<cr>', { noremap = true, silent = false })

-- joins selected lines
bind("n", "J", "mzJ`z", { noremap = true })

-- breakline
vim.cmd([[ nnoremap <cr> i<CR><ESC> ]])

bind("n", "<leader><down>", ':exe "resize " . (winheight(0) * 6/5)<cr>', { noremap = true })
bind("n", "<leader><up>", ':exe "resize " . (winheight(0) * 5/6)<cr>', { noremap = true })

-- To apply a command in a selected block
bind("v", ";", ":", {})

-- for surround plugin
bind("v", "s", "S", {})

-- remove trailing white space
vim.cmd([[nnoremap <leader>W :%s/\s\+$//<cr>:let @/='']])

-- fix for annoying man! (remaped for lsp)
-- bind("n", "K", "<nop>", {noremap = true})

-- use ,z to 'focus'   the current fold
-- bind("n", "<leader>z", "zmzvzz", {noremap = true})

-- substitute
bind("n", "<leader>ss", ":%s//<left>", {})
vim.cmd([[ vmap <leader>ss :s/\%V//<left><left> ]])

-- Bubble single lines
bind("n", "<c-a-j>", "]e", {})
bind("n", "<c-a-k>", "[e", {})

-- Bubble multiple lines
bind("v", "<c-a-k>", "]egv", {})
bind("v", "<c-a-j>", "[egv", {})

-- clear last highlight
bind("n", "<leader><leader>", ":silent noh<cr>", { silent = true })
bind("n", "<leader>sft", ":set filetype=", { noremap = true })
bind("n", "<leader>sfj", ":set filetype=javascript", { noremap = true })
bind("n", "<leader>sfm", ":set filetype=markdown", { noremap = true })

bind("n", "<leader>q", "<esc>:call FecharBuffer()<cr>", {})
-- vim.cmd([[ nnoremap <leader>q :call FecharBuffer()<cr> ]])
-- vim.cmd([[ autocmd FileType NvimTree nnoremap <leader>q :NvimTreeClose<cr> ]])


bind("n", "<leader>og", ':!open -a "google chrome"  %<cr>', {})

-- folding
-- bind("n", "zr", "zR", {noremap = true})
-- bind("n", "zm", "zM", {noremap = true})

--  no dollar sign at end of line
bind("", "<leader>cd", ":cd %:p:h<cr>", {})

-- maps for jj to act as esc
bind("i", "jj", "<esc>", { noremap = true })
-- bind("c", "jj", "<c-c>", { noremap = true })

-- force saving files that require root permission
bind("c", "w!!", "%!sudo tee > /dev/null %", {})

-- vv select the content of the cur line without indent
bind("n", "vv", "^vg_", { noremap = true })
bind("n", "Y", "y$", { noremap = true })

-- keep the visual selection after shifting tabs
bind("v", ">", "><CR>gv", { noremap = true })
bind("v", "<", "<<CR>gv", { noremap = true })

-- open a quickfix window for the last search
bind("n", "<leader>co", ":copen", { noremap = true })

-- window management
bind("n", "H", "<c-w>h", { noremap = true })
bind("n", "L", "<c-w>l", { noremap = true })

-- bind("n", "<leader>sfi", ":set fdm=indent<cr>", { noremap = true })
-- bind("n", "<leader>sfm", ":set fdm=marker<cr>", { noremap = true })

bind("n", "<leader>]", ":bn<cr>", { noremap = true })
bind("n", "<leader>[", ":bp<cr>", { noremap = true })

bind("n", "<c-d>", "<c-d>zz", {})
bind("n", "<c-e>", "<c-u>zz", {})

-- Super useful! From an idea by Michael Naumann
bind("v", "*", ':call VisualSelection("f")<CR>', { noremap = true })
bind("v", "#", ':call VisualSelection("b")<CR>', { noremap = true })

bind("n", "<leader>vv", ":e $MYVIMRC<cr><c-w>", {})
bind("n", "<leader>vm", ":e ~/.config/nvim/lua/mappings.lua<cr><c-w>", {})
bind("n", "<leader>vp", ":e ~/.config/nvim/lua/plugins/init.lua<cr><c-w>", {})
bind("n", "<leader>vo", ":e ~/.config/nvim/lua/options.lua<cr><c-w>", {})
bind("n", "<leader>vz", ":e $HOME/.zshrc<cr><c-w>", {})
bind("n", "<leader>va", ":e ~/.config/alacritty/alacritty.toml<cr><c-w>", {})


bind("n", "<leader>vs", "<esc>:vsplit<cr>", {})
bind("n", "<leader>vh", "<esc>:split<cr>", {})
-- bind("v", "y", "y:call ClipboardYank()<cr>", {noremap = true})
-- bind("v", "d", "d:call ClipboardYank()<cr>", {noremap = true})
-- bind("v", "x", "d:call ClipboardYank()<cr>", {noremap = true})
-- bind("n", "p", ":call ClipboardPaste()<cr>p", {noremap = true})

-- ctrl+j/ctrl+i to iterate in list
bind("i", "<c-j>", "<c-n>", {})
bind("i", "<c-k>", "<c-p>", {})

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

bind("c", "<c-j>", "<c-n>", {})
bind("c", "<c-k>", "<c-p>", {})

bind('n', '<leader>d', '\"_d', {})
bind('v', '<leader>d', '\"_d', {})

bind('x', "<leader>p", "\"_dP", {})
-- copies current file dir to buffer
bind('n', "<leader>fd", ":let @+ = expand('%:p:h')", {})

vim.api.nvim_set_keymap("n", "<leader>ob", ":e ~/GDrive/_NOTAS/obsidian", {})


--" URL encode/decode selection
vim.cmd [[
  vnoremap <leader>en :!python3 -c 'import sys; from urllib import parse; print(parse.quote_plus(sys.stdin.read().strip()))'<cr>
  vnoremap <leader>de :!python3 -c 'import sys; from urllib import parse; print(parse.unquote_plus(sys.stdin.read().strip()))'<cr>
]]

vim.cmd( [[command! CPF :let @+ = system('node '.stdpath("config").'/myPlugins/plugin/node/geradorCPF.js')  | echo 'CPF: '.@+ ]])


function get_visual_selection()
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
  return table.concat(lines, '\n')
end

function ExecuteFile(type)
  local context
  if (type == 'v') then
    local selection = get_visual_selection()
    print(selection:gsub("\\([nt])", { n = "\n", t = "\t" }))
    context = "\"" .. selection:gsub("\\([nt])", { n = "\n", t = "\t" }) .. "\""
  else
    context = '%'
  end
  local lang = {
    javascript = ':!ts-node ' .. context,
    typescript = ':!npx tsx ' .. context
  }
  vim.cmd(lang[vim.bo.filetype])
end

vim.api.nvim_set_keymap('n', '<leader><cr>', ':lua ExecuteFile("n")<cr>', {})
vim.api.nvim_set_keymap('v', '<leader><cr>', ':lua ExecuteFile("v")<cr>', {})
