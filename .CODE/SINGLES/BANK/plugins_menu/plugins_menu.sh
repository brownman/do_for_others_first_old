#!/bin/bash -e
file_list=`$dir_old_sh/list.txt`
choose=$( zenity1 "$file_list" )
notify-send 'run: task' "$choose"
