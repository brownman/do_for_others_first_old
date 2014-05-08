#!/bin/bash -e
#depend: assert()

path=`dirname $0`

setup(){
export dir_cfg=$path/cfg
}

test_exports(){
    source $dir_cfg/exports.cfg
#    (  export $dir_wrapper )
local cmd='assert dir_exist $dir_wrapper'
echo "$cmd"
eval "$cmd"
}


test_funcs(){
source $dir_cfg/funcs.cfg
#   [ type proxy ] && { echo "func: proxy: is defined"; }
   assert func_exist proxy
}
test_vars(){
    source $dir_cfg/vars.cfg
#   [ -n $time ] && { echo "var: time: $time"; }
    assert string_exist "$time"
}

steps(){
    setup
test_exports
#test_vars
#test_funcs
}


steps
