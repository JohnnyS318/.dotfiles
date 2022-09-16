-- space as leader key
vim.g.mapleader = " "

-- Encoding
vim.opt.fileencoding = "utf-8"

-- linenumber column
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"

-- tabwidth
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

-- wrapping
vim.opt.wrap = false
vim.opt.showbreak = "↪"

vim.opt.scrolloff = 8

-- preserve undo history
vim.bo.undofile = true

-- enable mouse support
vim.opt.mouse = "a"

-- use system clipboard
vim.o.clipboard = "unnamedplus"

-- 24-bit colors
vim.opt.termguicolors = true

-- column at 120 characters to indicate max line width
vim.opt.colorcolumn = "120"

-- disable mode display because it is handled by airline
vim.opt.showmode = false

-- VIMSCRIPT SECTION
-- jump to last cursor position when opening previously opened file
vim.cmd [[
    autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
]]
