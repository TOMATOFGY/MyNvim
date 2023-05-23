
function fqy_edit_config()
	vim.cmd("edit ~/.config/nvim/init.lua")
end

function fqy()
	print ("hello")
end


-- 打开今日日记
function _G.OpenTodayDiary()
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
end


vim.api.nvim_set_keymap("n","<Leader>ud",":lua OpenTodayDiary()<CR>",{ noremap = true, silent = true })
