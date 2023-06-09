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

-- 在任何模式下按 j k 都是为了离开当前模式.进一步省略按 ESC 的需要
-- vim.keymap.set('t', 'jk', "<C-\\><C-n>",{}) -- 暂时先放弃,因为加上这个后使用非常卡顿
vim.keymap.set('c', 'jk', "<ESC>",{})

-- 不要在快速按 qq 的时候直接 recored macro
vim.keymap.set('n', 'qq', "",opts)

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


local cache_dir = vim.fn.stdpath("cache")
print (cache_dir)


-- 得到当前文件夹所在的目录
function getCurrentScriptFolderPath()
  local info = debug.getinfo(1, "S")
  local path = info.source:sub(2) -- 去掉路径前面的 '@' 字符
  return string.match(path, "(.*/)") or "./"
end

-- TODO 获取当前 buffer 所在的目录
-- TODO 将 nvim 的当前工作路径设置为当前 buffer 所在的目录

print(getCurrentScriptFolderPath())

function openCurBufferDir()
  local curBufferDir = vim.fn.expand("%")
  curBufferDir = string.match(curBufferDir, "(.*/)") or "./"
  local cmd = ":cd " .. curBufferDir
  print(cmd)
  vim.cmd(cmd)
end
vim.keymap.set("n","<Leader>ec",openCurBufferDir,opts)

-- 快速切换到父级目录
-- 或许应该在 tree 中实现
vim.keymap.set("n","<Leader>eh",":cd ..<CR>",opts)


-- ⭕️目前遇到了一个问题,首次打开nvim 会报错
-- 不了解那个 config 是不是全局变量
---- require("noice").setup({
  --lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    -- override = {
    --   ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
    --   ["vim.lsp.util.stylize_markdown"] = true,
    --   ["cmp.entry.get_documentation"] = true,
    -- },
    --override = {
      --["vim.lsp.hover.enable"] = false
    --}
  --},
  ---- you can enable a preset for easier configuration
  --presets = {
    --bottom_search = true, -- use a classic bottom cmdline for search
    --command_palette = true, -- position the cmdline and popupmenu together
    --long_message_to_split = true, -- long messages will be sent to a split
    --inc_rename = false, -- enables an input dialog for inc-rename.nvim
    --lsp_doc_border = false, -- add a border to hover docs and signature help
  --},
--})
