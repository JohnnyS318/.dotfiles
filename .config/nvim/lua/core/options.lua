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

vim.opt.smartindent = false

-- gui features

vim.opt.mouse = "a"

-- 24-bit colors
vim.opt.termguicolors = true

vim.opt.showtabline = 2

--speedup loading
vim.g.skip_ts_context_commmentstring_module = true

-- close quickfix menu after selecting choice
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "qf" },
    command = [[nnoremap <buffer> <CR> <CR>:cclose<CR>]],
})

vim.api.nvim_create_autocmd(
    "BufReadPost",
    { pattern = "quickfix", command = [[nnoremap <buffer> <CR <CR>:cclose<CR>]] }
)
