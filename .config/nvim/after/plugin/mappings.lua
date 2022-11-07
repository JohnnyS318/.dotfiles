local Remap = require("gobidev.keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local nmap = Remap.nmap

-- Shorten function name
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

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
nnoremap("<leader>d", '"_d')
nnoremap("<leader>c", '"_c')
nnoremap("<leader>D", '"_D')
nnoremap("<leader>C", '"_C')

-- jk to exit insert mode
inoremap("jk", "<ESC>")

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- close buffer
nnoremap("<leader>x", ":bd<CR>")
