-- file for keymappings

-- Map q: to a no-operation
vim.api.nvim_set_keymap("n", "q:", "<NOP>", { noremap = true, silent = true })

-- window stuff
vim.keymap.set({ "n" }, "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
vim.keymap.set({ "n" }, "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
vim.keymap.set({ "n" }, "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
vim.keymap.set({ "n" }, "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Move Lines
vim.keymap.set({ "n" }, "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
vim.keymap.set({ "n" }, "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
vim.keymap.set({ "i" }, "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
vim.keymap.set({ "i" }, "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
vim.keymap.set({ "v" }, "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
vim.keymap.set({ "v" }, "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- save file (sin i know...)
vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
