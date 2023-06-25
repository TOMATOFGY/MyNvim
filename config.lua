-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

lvim.plugins = {
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require 'colorizer'.setup({
        -- 对所有文件类型都开启颜色高亮
        "*",
      }, {
        RRGGBBAA = true,
        css = true
      })
    end,
  },
  {
    "phaazon/hop.nvim",
    event = "BufRead",
    config = function()
      require("hop").setup()
      vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
      vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
    end,
  },
  --[[
  {
    "kevinhwang91/rnvimr",
    cmd = "RnvimrToggle",
    config = function()
      vim.g.rnvimr_draw_border = 1
      vim.g.rnvimr_pick_enable = 1
      -- 下面这一行是干什么的?
      -- vim.g.rnvimr_bw_enable = 1
      vim.g.rnvimr_enable_ex = 1
    end,
  },
  --]]
  {
    "kelly-lin/ranger.nvim",
    config = function()
      require("ranger-nvim").setup({
        --        replace_netrw = true
      })
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        messages = {
          -- NOTE: If you enable messages, then the cmdline is enabled automatically.
          -- This is a current Neovim limitation.
          enabled = true,        -- enables the Noice messages UI
          view = "notify",       -- default view for messages
          view_error = "notify", -- view for errors
          view_warn = "notify",  -- view for warnings
          view_history = "messages", -- view for :messages
          view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
        }
      })
    end
  },
  {
    'simrat39/symbols-outline.nvim',
    enabled = true,
    config = function()
      -- 🍅❓: 为什么需要手动启动setuo?
      require("symbols-outline").setup()
    end
  },
  {
    "s1n7ax/nvim-window-picker",
    version = "1.*",
    config = function()
      require("window-picker").setup({
        autoselect_one = true,
        include_current = false,
        -- spacevim 风格的窗口切换
        selection_chars = '1234567890',
        filter_rules = {
          -- filter using buffer options
          bo = {
            -- if the file type is one of following, the window will be ignored
            filetype = { "neo-tree", "neo-tree-popup", "notify", "quickfix" },

            -- if the buffer type is one of following, the window will be ignored
            -- buftype = { "terminal" },
          },
        },
        other_win_hl_color = "#e35e4f",
      })
    end,
  },


}


-- example mappings you can place in some other place
-- An awesome method to jump to windows
local picker = require('window-picker')


local pick_a_window = function()
  local picked_window_id = picker.pick_window({
    include_current_win = true
  }) or vim.api.nvim_get_current_win()
  vim.api.nvim_set_current_win(picked_window_id)
end

vim.keymap.set("n", ",w", pick_a_window, { desc = "Pick a window" })



-- 覆盖,将 Leader-r 映射到打开 ranger
local open_ranger_with_project_path = function()
  require("ranger-nvim").open(false)
end

local open_ranger_with_buffer_path = function()
  require("ranger-nvim").open(true)
end

lvim.keys.normal_mode["<Leader>r"] = open_ranger_with_buffer_path
-- lvim.keys.normal_mode["<Leader>r"] = open_ranger_with_project_path
lvim.keys.normal_mode["<Leader>lo"] = ":SymbolsOutline<cr>"
lvim.keys.normal_mode["<Leader>,"] = pick_a_window


local Mappings = {}

-- 有关 lvim 的自定义
-- 调整 tree 在右边
lvim.builtin.nvimtree.setup.view.side = "right"



MY = {
  open_config = function()
    vim.cmd ":edit ~/.config/nvim/init.lua"
  end,

  open_today_diary = function()
    -- 当天日记存储在 "${proj_my_documents}/Diary/${date}.md"
    -- MyDocuments 项目所在路径
    local proj_my_documents = "~/Documents/Github/MyDocuments"
    -- 获取当前日期 %Y-%m-%d, e.g. 2023-05-22
    local get_date = function()
      local date = os.date("%Y-%m-%d")
      return date
    end

    -- 检查文件 "${proj_my_documents}/Diary/${date}.md" 是否存在,如果不存在,则创建
    local check_file = function()
      local date = get_date()
      local file_path = proj_my_documents .. "/Diary/" .. date .. ".md"
      local file = io.open(file_path, "r")
      if file == nil then
        -- 尝试新建一个文件
        file = io.open(file_path, "w")
      end
    end
    check_file()
    -- 打开文件
    local date = get_date()
    local file_path = proj_my_documents .. "/Diary/" .. date .. ".md"
    vim.cmd("edit " .. file_path)
  end,

  open_cur_month_diary = function()
    -- 当天日记存储在 "${proj_my_documents}/Diary/${date}.md"
    -- MyDocuments 项目所在路径
    local proj_my_documents = "~/Documents/Github/MyDocuments"
    -- 获取当前日期 %Y-%m-%d, e.g. 2023-05-22
    local get_date = function()
      local date = os.date("%Y-%m")
      return date
    end

    -- 检查文件 "${proj_my_documents}/Diary/${date}.md" 是否存在,如果不存在,则创建
    local check_file = function()
      local date = get_date()
      local file_path = proj_my_documents .. "/Diary/" .. date .. ".md"
      local file = io.open(file_path, "r")
      if file == nil then
        -- 尝试新建一个文件
        file = io.open(file_path, "w")
      end
    end
    check_file()
    -- 打开文件
    local date = get_date()
    local file_path = proj_my_documents .. "/Diary/" .. date .. ".md"
    vim.cmd("edit " .. file_path)
  end,

  say_hello = function()
    print "hello"
  end
}

-- 得到当前文件在文件系统上的位置
function getCurrentScriptFolderPath()
  local info = debug.getinfo(1, "S")
  local path = info.source:sub(2) -- 去掉路径前面的 '@' 字符
  return string.match(path, "(.*/)") or "./"
end

MY.reload = function()
  local dir = getCurrentScriptFolderPath()
  local my_config_path = dir .. "/init.lua"
  dofile(my_config_path)
  --  print "RELOAD MY CONFIG!!"
end

lvim.keys.normal_mode["<leader>ud"] = MY.open_today_diary
lvim.keys.normal_mode["<leader>um"] = MY.open_cur_month_diary
-- 🍅 : 为什么不会直接显示出来?
lvim.builtin.which_key.mappings[";"] = { ":", "open cmd line" }
lvim.keys.normal_mode[";"] = ':'



---@alias telescope_themes
---| "cursor"   # see `telescope.themes.get_cursor()`
---| "dropdown" # see `telescope.themes.get_dropdown()`
---| "ivy"      # see `telescope.themes.get_ivy()`
---| "center"   # retain the default telescope theme
-- 调回最顺眼的居中显示
lvim.builtin.telescope.theme = "center"
-- 取消 lvim 自带的快捷键
-- 取消方式参见
lvim.builtin.which_key.mappings["f"] = {}
-- 换上telescope自带的快捷键
lvim.keys.normal_mode["<Space>ff"] = ":Telescope find_files<CR>"
lvim.keys.normal_mode["<Space>fg"] = ":Telescope live_grep<CR>"
lvim.keys.normal_mode["<Space>fb"] = ":Telescope buffers<CR>"
lvim.keys.normal_mode["<Space>fh"] = ":Telescope help_tags<CR>"
lvim.keys.normal_mode["<Space>fn"] = ":Telescope notify<CR>"


lvim.builtin.which_key.mappings["t"] = { ":set wrap<CR>", "开启 wrap" }

-- 获取当前窗口的名字
get_current_window_name = function()
  -- 执行":echo bufname('%')"并获得其标准输出,保存至current_window_name
  local current_window_name = vim.api.nvim_exec(":echo bufname('%')", true)
  return current_window_name
end

-- 1. 如果是当前窗口是浮动窗口,则关闭浮动窗口
-- 2. 如果当前窗口名字包含MY.buffer_change_forbidden_list中的字符串(不区分大小写),则不做任何处理
MY.buffer_change_forbidden_list = {
  "NvimTree",
  "NvimTree_1",
  "Outline",
  "OUTLINE"
}
MY.move_to_next_buffer = function()
  local current_window_name = get_current_window_name()
  for i, name in ipairs(MY.buffer_change_forbidden_list) do
    if string.find(current_window_name, name, 1, true) ~= nil then
      return
    end
  end
  vim.cmd(":bn")
end
MY.move_to_prev_buffer = function()
  local current_window_name = get_current_window_name()
  for i, name in ipairs(MY.buffer_change_forbidden_list) do
    if string.find(current_window_name, name, 1, true) ~= nil then
      return
    end
  end
  vim.cmd(":bp")
end
lvim.keys.normal_mode["<Tab>"] = MY.move_to_next_buffer
lvim.keys.normal_mode["<S-Tab>"] = MY.move_to_prev_buffer

vim.schedule(function()
  vim.notify("try to schedule sth")
  lvim.keys.normal_mode["<Space>f"] = false
  lvim.keys.normal_mode["<Leader>f"] = false
end)

-- 尝试将快捷键的组织方式按 nvchard 的方式组织
local keymap = {}
keymap.set = vim.api.nvim_set_keymap
keymap.set("x", "J", ":move '>+1<CR>gv-gv", {})
keymap.set("x", "K", ":move '<-2<CR>gv-gv", {})
local Mappings = {}
Mappings.my_visual = {
  x = {
    ["J"] = {
      ":move '>+1<CR>gv-gv",
      "move selected block up"
    },
    ["K"] = {
      ":move '<-2<CR>gv-gv",
      "move selected block down"
    },
  }
}

vim.notify("Reloaded customed configure", "info", {
  title = "🍅 RELOAD MY CONFIG",
  render = 'compact'
})

-- 修改lvim内嵌 terminal 的打开方式
lvim.builtin.terminal.open_mapping = "<c-`>"
lvim.builtin.terminal.direction = 'horizontal'


-- alias jk as <ESC> in input mode
lvim.keys.insert_mode["jk"] = "<ESC>"

