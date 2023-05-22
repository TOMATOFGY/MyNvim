
local lazypath = "./data/lazy/lazy.nvim"
-- 如果没找到该文件，说明是第一次加载本配置文件，首先gitclone lazyvim
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


