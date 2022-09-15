local Remap = require("gobidev.keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local nmap = Remap.nmap

-- centered jumping
nnoremap("n", "nzz")
nnoremap("N", "Nzz")
nnoremap("*", "*zz")
nnoremap("#", "#zz")
nnoremap("n", "nzz")
nnoremap("g*", "g*zz")

nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")

-- stop searching
nnoremap("<leader>h", "<cmd>:nohlsearch<CR>")
vnoremap("<leader>h", "<cmd>:nohlsearch<CR>")

-- Ctrl+k as Esc
inoremap("<C-k>", "<Esc>")

-- using home row keys to jump to front/end of line
nnoremap("H", "^")
nnoremap("L", "$")

-- quick save and quit
nnoremap("<leader>w", "<cmd>:w<CR>")
nnoremap("<leader>q", "<cmd>:q<CR>")

-- delete without yanking
nnoremap("<leader>d", "_d")
nnoremap("<leader>c", "_c")
nnoremap("<leader>x", "_x")
nnoremap("<leader>D", "_D")
nnoremap("<leader>C", "_C")

-- git
nnoremap("<leader>ga", "<cmd>:Git add -p<CR>")
nnoremap("<leader>gc", "<cmd>:Git commit -v<CR>")
nnoremap("<leader>gp", "<cmd>:Git push<CR>")
nnoremap("<leader>gl", "<cmd>:Git pull<CR>")

