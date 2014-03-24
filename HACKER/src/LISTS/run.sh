#!/bin/bash -e
path=`dirname $0`
pushd "$path">/dev/null
export file_recent_list=$path/recent_list.txt

run_dir(){
    dir=$1
    pushd "$dir">/dev/null
   "$sh_list"
    popd>/dev/null

}

echo 'if simple list is available: run the primary list'
dir=`cat $file_recent_list | head -1`
run_dir $path/$dir
popd>/dev/null

