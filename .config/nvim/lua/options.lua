-- vim.cmd("set termguicolors")
vim.cmd [[
 if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif
]]

local o = vim.opt
local wo = vim.opt
local bo = vim.opt

vim.cmd [[ set fillchars=fold:\ ,vert:\│,eob:\ ,msgsep:‾ ]]
vim.cmd [[
  au BufWinEnter * set formatoptions-=cro
]]
vim.opt_local.formatoptions:remove({ 'r', 'o', 'c' })
vim.g.mapleader = " "

vim.g.maplocalleader = " "


o.mouse = ''
vim.opt.undofile = true
wo.number = true
o.termguicolors = true
bo.synmaxcol = 80
wo.cursorcolumn = false
wo.cursorline = false
vim.opt.clipboard = { "unnamed", "unnamedplus" }
o.ttimeout = false
o.timeout = false
wo.foldmethod = "expr"
wo.foldexpr = "nvim_treesitter#foldexpr()"
wo.relativenumber = false
wo.numberwidth = 5
o.visualbell = true
o.errorbells = true
bo.swapfile = false
o.hidden = true
o.confirm = true
o.showmatch = true
bo.smartindent = true
o.foldopen = "block,insert,jump,mark,percent,quickfix,search,tag,undo"
o.virtualedit = "all"
o.splitright = true
o.splitbelow = true
bo.cindent = true
bo.expandtab = true
bo.softtabstop = 1
bo.tabstop = 1
o.shiftwidth = 2
bo.shiftwidth = 2
bo.cinkeys = "0{,0},0[,0]"
o.lazyredraw = true
o.showmatch = true
o.matchtime = 2
o.showmatch = true
wo.wrap = false
o.ignorecase = true
o.smartcase = true
o.gdefault = true
o.wildmode = "list:longest,full"
bo.infercase = true
vim.opt.completeopt = { "menuone", "noselect" }
o.backup = false
o.writebackup = false
bo.swapfile = false
o.swapfile = false
wo.list = false
bo.copyindent = true
o.shiftround = true
bo.modeline = true
o.showcmd = false



vim.opt.guicursor = {
  'n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50',
  'a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor',
  'sm:block-blinkwait175-blinkoff150-blinkon175',
}
