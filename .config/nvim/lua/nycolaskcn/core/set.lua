vim.g.mapleader = " "

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.scrolloff = 8

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.undodir = os.getenv("HOME") .. "/.config/nvim/undodir"
vim.opt.undofile = true
vim.opt.clipboard = "unnamedplus"

vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.guifont = "JetBrainsMono NFM:h17"  -- You can adjust the size (h14) as needed

vim.opt.termguicolors = true

