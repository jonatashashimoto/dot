local bind = vim.api.nvim_set_keymap

-- smart curly braces enter (indents it properly)
vim.cmd [[ inoremap <expr> <cr> getline(".")[col(".")-2:col(".")-1]=="{}" ? "<cr><esc>O" : "<cr>" ]]

bind("n", "<leader>so", ":so %<cr>", { noremap = true, silent = false })

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

-- substitute
bind("n", "<leader>ss", ":%s//<left>", {})
vim.cmd([[ vmap <leader>ss :s/\%V//<left><left> ]])

-- clear last highlight
bind("n", "<leader><leader>", ":silent noh<cr>", { silent = true })
bind("n", "<leader>sft", ":set filetype=", { noremap = true })
bind("n", "<leader>sfj", ":set filetype=javascript", { noremap = true })
bind("n", "<leader>sfm", ":set filetype=markdown", { noremap = true })

bind("n", "<leader>q", "<esc>:call FecharBuffer()<cr>", {})

bind("n", "<leader>og", ':!open -a "google chrome"  %<cr>', {})

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


bind("n", "<leader>sv", "<esc>:vsplit<cr>", {})
bind("n", "<leader>sh", "<esc>:split<cr>", {})

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


-- NOTE: donot trigger autocmd when executing macro
-- https://www.reddit.com/r/neovim/comments/tsol2n/comment/i2ugipm/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
vim.cmd([[
  xnoremap @ :<C-U>execute "noautocmd '<,'>norm! " . v:count1 . "@" . getcharstr()<cr>
  nnoremap @ <cmd>execute "noautocmd norm! " . v:count1 . "@" . getcharstr()<cr>
]])
