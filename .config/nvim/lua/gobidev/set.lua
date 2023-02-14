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
vim.cmd([[
    autocmd FileType markdown setlocal ts=2 sts=2 sw=2
    autocmd FileType json setlocal ts=2 sts=2 sw=2
    autocmd FileType jsonc setlocal ts=2 sts=2 sw=2
    autocmd FileType json5 setlocal ts=2 sts=2 sw=2
    autocmd FileType toml setlocal ts=2 sts=2 sw=2
    autocmd FileType make setlocal ts=4 sts=0 sw=4 noexpandtab
]])

vim.opt.smartindent = true

-- wrapping
vim.opt.wrap = false
vim.cmd([[
    autocmd FileType markdown setlocal wrap
]])
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
vim.cmd([[
     autocmd FileType gitcommit setlocal colorcolumn=72
    autocmd FileType python setlocal colorcolumn=79
    autocmd FileType markdown setlocal colorcolumn=80
    autocmd FileType rust setlocal colorcolumn=100
]])

-- disable mode display because it is handled by airline
vim.opt.showmode = false

vim.g.vim_markdown_folding_disabled = 1

-- send osc52 sequence on yank
local function copy()
    if vim.v.event.operator == 'y' then
        require('osc52').copy_register(vim.v.event.regname)
    end
end

vim.api.nvim_create_autocmd('TextYankPost', { callback = copy })

vim.cmd([[
    " Highlight yanking
    au TextYankPost * silent! lua vim.highlight.on_yank()

    " Jump to last open pos
    autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
]])
