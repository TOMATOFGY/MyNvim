-- 2023-05-28 00:28:42 有时候 ranger 并不能发挥作用
-- 🍅 : 本文件需要支持能重入,这样能方便重新载入
-- 2023-05-26 18:24:19 TODO tab 上需要显示文件的全路径,不然夸文件夹同名看不出来是哪个文件
-- 2023-05-26 18:32:28 TODO 获取当前buffer 中显示的文件的路径,打开 NvimTree 的时候可以选择打开当前文件路径还是项目路径还是 nvim 的当前路径
print "USE FANQIANYI CONFIG"
local keymap = vim.keymap

-- 对第三方 plugin 进行映射
-- 考虑以回调的形式写在 lazyvim 里面
local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>fu', ":Telescope undo<CR>", {})
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

vim.keymap.set('n', '<leader>ww', ":w<CR>" , {})
vim.keymap.set('n', '<leader>wq', ":w<CR>:x<CR>" , {})
vim.keymap.set('n', '<leader>qq', ":q<CR>" , {})

-- 对自定义函数进行映射
require("my.functions")

vim.keymap.set('n', '<leader>mc', MY.open_config, {})
vim.keymap.set('n', '<leader>mm',":edit ~/.config/nvim/lua/my/init.lua<CR>" , {})
vim.keymap.set("n","<Leader>ud",MY.open_today_diary,{ noremap = true, silent = true })
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- 快速关闭 NvimTree
keymap.set("n","<Leader>de",":NvimTreeClose<CR>",opts)

-- Visual Block
-- Move text up and down
-- 但是这种方式移动到最低端的时候会报错
keymap.set("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap.set("x", "K", ":move '<-2<CR>gv-gv", opts)

keymap.set("t","<C-k>","<C-w><C-k>",opts);
keymap.set("t","<C-j>","<C-w><C-j>",opts);
keymap.set("t","<C-J>","<C-W><C-J>",opts);
keymap.set("t","<C-J>","<C-W><C-J>",opts);

-- 覆盖,将 Leader-r 映射到打开 ranger
vim.keymap.set("n", "<leader>rr", "", {
        noremap = true,
        callback = function()
          require("ranger-nvim").open(true)
        end,
})

vim.keymap.set("n", "<leader>re", "", {
        noremap = true,
        callback = function()
          require("ranger-nvim").open(false)
        end,
})


vim.keymap.set('n', '<leader>mr', MY.reload, {})

-- 配置 hop
local hop = require 'hop'
hop.setup()
vim.keymap.set('n', '<leader>fw', ":HopWord<CR>", {})

-- 配置 lazygit
local lazygit = require 'lazygit'
vim.keymap.set('n', '<leader>gg', ":LazyGit<CR>", {})


-- lazygit.setup()

-- require("lazy").setup({
  --ranger_config
--})

-- 定义一个user defined 的 cmd
-- 输入":Q"将执行":q"
vim.cmd("command! Q q")
vim.cmd("command! W w")
vim.cmd("command! Wq wq")
vim.cmd("command! WQ wq")
