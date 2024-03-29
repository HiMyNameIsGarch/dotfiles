vim.g.mapleader = " "

local o = vim.opt

o.laststatus = 3 -- oh yeah
o.guicursor = ""
o.relativenumber = true
o.hlsearch = false
o.errorbells = false
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth= 4
o.smartindent = true
o.expandtab = true
o.wrap = false
o.nu = true
o.hidden = true
o.smartcase = true
o.swapfile = false
o.backup = false
o.undodir = vim.fn.stdpath('config') .. '/undodir'
o.undofile = true
o.incsearch = true
o.scrolloff = 8
o.sidescroll= 8
o.sidescrolloff = 8
o.showmode = false
o.completeopt = { "menu", "menuone", "noinsert", "noselect" }
o.colorcolumn = "80"
o.signcolumn = "yes"
o.cmdheight = 1
o.updatetime = 50
o.showcmd = true
o.splitright = true

-- Netrw
vim.g.netrw_banner= 0
vim.g.netrw_winsize = 25
vim.g.netrw_browse_split = 0
