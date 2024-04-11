-- close quickfix menu after selecting choice
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "qf" },
    command = [[nnoremap <buffer> <CR> <CR>:cclose<CR>]],
})

vim.api.nvim_create_autocmd(
    "BufReadPost",
    { pattern = "quickfix", command = [[nnoremap <buffer> <CR <CR>:cclose<CR>]] }
)
