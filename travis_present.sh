#!/bin/bash 
set -o nounset
export dir_root=`pwd`
arg=${1:-shunit}
cmd="$dir_root/works/test/0.0.1/test.sh $arg"
#source $dir_root/.breath.cfg
echo "$cmd"
eval "$cmd"

#echo "vi $cmd" | /usr/bin/xsel --clipboard
