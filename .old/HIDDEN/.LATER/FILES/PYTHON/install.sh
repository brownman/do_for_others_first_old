#!/bin/bash

func(){
local dir_self=`pwd`
local file="$dir_self/INSTALL/3.sh"
echo "$file"
cat "$file"
sleep 3
eval "$file"
}
func
