#!/bin/bash -e
export file_tmp=/tmp/file_tmp

commander(){
    cmd="$1"
echo "[cmd] $cmd"
eval "$cmd" 2>/dev/null

}
print_state(){
    set -o | grep pipefail
}

test_grep(){
print_state
    echo hiii > $file_tmp
#    grep hxi  $file_tmp
cmd="cat $file_tmp | grep hxi"
commander "$cmd"
local     res=$?
    echo "res: $res"
}

wrap_test_grep(){
    set +o pipefail
    test_grep
    set -o pipefail
    test_grep

}

steps(){
    wrap_test_grep
}

steps

