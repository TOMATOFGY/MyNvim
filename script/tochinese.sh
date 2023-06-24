#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title toChinese
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.author tomatofaq
# @raycast.authorURL https://raycast.com/tomatofaq


# 获得macos当前输入法的名字

# 一个函数，用于切换输入法
function switch() {
# 触发快捷键 ctrl-space
osascript -e 'tell application "System Events" to keystroke " " using control down'
}

NAME=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist | grep "AppleSelectedInputSources" -A10 | grep "KeyboardLayout Name" | sed -E 's/^[[:space:]]*"KeyboardLayout Name" = "(.*)";/\1/')
# 如果当前输入法是英文,即名字包含"U.S."，则切换到中文
if [[ $NAME =~ "U.S." ]]; then
	switch
fi