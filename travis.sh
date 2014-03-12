#!/bin/bash
export dir_root=`pwd`
cmd="$dir_root/works/test/0.0.1/test.sh"
source $dir_root/.breath
echo "$cmd"
eval "$cmd"

echo "vi $cmd" | /usr/bin/xsel --clipboard
