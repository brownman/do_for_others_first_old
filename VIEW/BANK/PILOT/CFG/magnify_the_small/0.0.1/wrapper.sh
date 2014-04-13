#!/bin/bash
every 4 "set -o nounset"
pushd `dirname $0`>/dev/null
echo "[WRAPPER]"
toilet --gay wrapper


steps(){

#    local dir_self=`dirname $0`

export     dir_root=`where_am_i $0`
if [ -n "$cmd" ];then
    source $dir_root/setup.cfg
    proxy "$runner_debug $cmd"
else
    echo supply a script to wrap
fi

}
args=( $@ )
cmd="${args[@]}"
steps
popd>/dev/null
