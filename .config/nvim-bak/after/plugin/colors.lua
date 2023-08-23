vim.cmd('colorscheme gruvbox')

-- colors for diffs
vim.api.nvim_set_hl(0, '@text.diff.add', { link = 'DiffAdded' })
vim.api.nvim_set_hl(0, '@text.diff.delete', { link = 'DiffRemoved' })
