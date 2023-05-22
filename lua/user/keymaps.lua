local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- 快速切换 buffer
keymap("n","<S-l>", ":bnext<CR>",opts)
keymap("n","<S-h>", ":bprevious<CR>",opts)

-- 快速切换 pane
keymap("n","<C-H>", "<C-w>h",opts)
keymap("n","<C-J>", "<C-w>j",opts)
keymap("n","<C-K>", "<C-w>k",opts)
keymap("n","<C-L>", "<C-w>l",opts)

keymap("n","<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.mapleader = " "

keymap("n","<Leader>e",":NvimTreeFocus<CR>",opts)

-- 删除当前窗口
keymap("n","<Leader>q",":q<CR>",opts)
keymap("n","<Leader>w",":w<CR>",opts)
-- 删除当前 buffer
keymap("n","<Leader>x",":bdelete<CR>",opts)


