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

o.mouse = 'nv'
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
wo.relativenumber = true
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
-- o.lazyredraw = true
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
vim.cmd [[ set signcolumn=yes:2 ]]

-- vim.cmd(string.format([[highlight WinBar1 guifg=%s]], #ffffff))
-- vim.cmd(string.format([[highlight WinBar2 guifg=%s]], #000000))

local function get_winbar_path()
  local full_path = vim.fn.expand("%:p")
  return full_path:gsub(vim.fn.expand("$HOME"), "~")
end
-- Function to get the number of open buffers using the :ls command
local function get_buffer_count()
  local buffers = vim.fn.execute("ls")
  local count = 0
  -- Match only lines that represent buffers, typically starting with a number followed by a space
  for line in string.gmatch(buffers, "[^\r\n]+") do
    if string.match(line, "^%s*%d+") then
      count = count + 1
    end
  end
  return count
end
-- Function to update the winbar
local function update_winbar()
  local home_replaced = get_winbar_path()
  local buffer_count = get_buffer_count()
  vim.opt.winbar = "%#WinBar1#%m "
      .. "%#WinBar2#("
      .. buffer_count
      .. ") "
      .. "%#WinBar1#"
      .. home_replaced
      .. "%*%=%#WinBar2#"
  -- I don't need the hostname as I have it in lualine
  -- .. vim.fn.systemlist("hostname")[1]
end
-- Autocmd to update the winbar on BufEnter and WinEnter events
vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
  callback = update_winbar,
})
