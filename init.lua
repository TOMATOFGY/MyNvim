-- 如果是在 vscode 中,则不加载插件
if vim.env.VSCODE == "1" then
  return
end


require "core"

local custom_init_path = vim.api.nvim_get_runtime_file("lua/custom/init.lua", false)[1]

if custom_init_path then
  dofile(custom_init_path)
end

require("core.utils").load_mappings()

function command(cmd)
  os = require("os")
  io = require("io")
  local handle = io.popen(cmd)
  local output = handle:read("*a")
  handle:close()
  return tostring(output)
end


local function getCurrentScriptFolderPath()
  local info = debug.getinfo(1, "S")
  local path = info.source:sub(2) -- 去掉路径前面的 '@' 字符
  return string.match(path, "(.*/)") or "./"
end

repository_path = getCurrentScriptFolderPath()

print(repository_path)

lazypath = repository_path .. "lazy/lazy.vim"

-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazypath) then
  require("core.bootstrap").gen_chadrc_template()
  require("core.bootstrap").lazy(lazypath)
end

dofile(vim.g.base46_cache .. "defaults")
vim.opt.rtp:prepend(lazypath)
require "plugins"


-- 个人配置 --
require "my"

