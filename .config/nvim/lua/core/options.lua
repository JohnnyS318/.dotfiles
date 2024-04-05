-- map(local) leader
vim.g.mapleader = " " -- set `mapleader` before lazy for correct mappigng
vim.g.maplocalleader = "\\" -- "\\"

-- encoding
vim.opt.fileencoding = "utf-8"

-- linenumbers
vim.opt.nu = true -- enable line numbers
vim.opt.relativenumber = false -- hate them
vim.opt.signcolumn = "yes"

-- tabs & spaces
vim.opt.tabstop = 4 -- TODO: maybe 2?
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.opt.smartindent = true

-- gui features

vim.opt.mouse = "a"

-- 24-bit colors
vim.opt.termguicolors = true

vim.opt.showtabline = 2
