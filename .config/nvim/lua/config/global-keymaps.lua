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
vim.keymap.set({ "v" }, "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
vim.keymap.set({ "v" }, "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- save file (sin i know...)
vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- moving lines Shift K is already defined to be hover
vim.keymap.set({ "n" }, "Y", ":m .-2<CR>==", { noremap = true, silent = true, desc = "Move Line Up" })
vim.keymap.set({ "n" }, "U", ":m .+1<CR>==", { noremap = true, silent = true, desc = "Move Line Down" })
vim.keymap.set({ "v" }, "Y", ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = "Move Lines Up" })
vim.keymap.set({ "v" }, "U", ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "Move Lines Down" })

-- todo
vim.keymap.set("n", "]t", function()
    require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
    require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })
