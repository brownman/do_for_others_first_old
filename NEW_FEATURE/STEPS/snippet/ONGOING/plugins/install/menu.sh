#!/bin/bash -e

steps(){

local  file="$dir_txt/hotkeys.txt"
local result=$( zenity1 $file )
echo "$result"

}
steps
