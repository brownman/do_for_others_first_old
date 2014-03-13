#!/bin/bash 
pushd `dirname $0`>/dev/null
export path=`pwd`
$lister_sh

#cmd="cd $PWD"
#echo "$cmd" | /usr/bin/xsel --clipboard
#echo "vi"


popd>/dev/null
