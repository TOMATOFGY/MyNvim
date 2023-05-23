local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- 快速切换 buffer
keymap("n","<tab>", ":bnext<CR>",opts)
keymap("n","<S-tab>", ":bprevious<CR>",opts)

-- 快速切换 pane
keymap("n","<C-H>", "<C-w>h",opts)
keymap("n","<C-J>", "<C-w>j",opts)
keymap("n","<C-K>", "<C-w>k",opts)
keymap("n","<C-L>", "<C-w>l",opts)

keymap("n","<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.mapleader = " "

keymap("n","<Leader>e",":NvimTreeFocus<CR>",opts)
keymap("n","<Leader>e",":NvimTreeFocus<CR>",opts)
keymap("i","jk","<ESC>",opts)

-- 删除当前窗口
keymap("n","<Leader>q",":q<CR>",opts)
keymap("n","<Leader>w",":w<CR>",opts)
-- 删除当前 buffer
keymap("n","<Leader>x",":bdelete<CR>",opts)

-- terminal 相关
keymap("n","<Leader>tt",":terminal<CR>A",opts)
keymap("t","<Esc>","<C-\\><C-n>",opts)

-- 补充一个在 terminal 情况下也能进行呼出 whichkey 的功能,然后可以根据这个进行退出操作
-- keymap("t","<Leader>","<C-\\><C-n> :lua WhichKey<CR>",opts)
-- keymap("t","<Leader><Leader>",vim.cmd('execute "normal! i' .. ' ' .. '"'),opts)
-- TODO 补充一个在非输入情况下,输入:q\:x等直接退出的功能

-- meta 函数
keymap("n","<Leader>mc",":lua fqy_edit_config()<CR>",opts)

-- 全局关闭
keymap("n","<Leader>de",":NvimTreeClose<CR>",opts)
keymap("n","<Leader>dx",":x<CR>",opts)
keymap("n","<Leader>dd",":bdelete!<CR>",opts)
keymap("n","<Leader>dq",":q<CR>",opts)
