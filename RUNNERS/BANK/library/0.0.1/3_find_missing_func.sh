#!/bin/bash
set_env(){
    #info: set the environment
    dir_library=$dir_library
        script=$dir_plugins/gmail-group/script.sh
        func=$( cat /tmp/func 2>/dev/null )
}

next_missing_func(){
    #info: find the next missing function
    #finish: update /tmp/func
#desc: run the script in a sub-shell
    ( eval "$script" 1>/tmp/out 2>/tmp/err )

    proxy "cat /tmp/out"
    
#check for any error codes
local    res=$?
if [ $res -eq 0 ];then
    echo "[SUCCESS] - no error found"
proxy    go_home
    else

    echo "[ERROR CODE] code: $res" 

    echo -n "[ERROR MSG] " 
    cat /tmp/err
   #parse error if the error is a missing function 
str0=$( cat /tmp/err | cut -d':' -f3 )

        func=$(echo "$str0" | sed -e 's/^ *//g' -e 's/ *$//g');

    echo -n $func > /tmp/func
    fi
}

find_func(){
    #info: grep for the function
    local  str=$func
#| xargs echo )
        echo "looking for function: _${str}_"
        echo press a key to continue
        read key1
        sleep 6
        cmd="$dir_library/0_search_from_root.sh $str"
        echo "$cmd"
        sleep 2
        eval "$cmd"
}

overrite_file(){
    #info: cp the file
    files=$( ls /tmp/$func)
        for file in $files;do
            ls $file
                done
}

steps(){
    #info: run all steps
set_env 
next_missing_func 
find_func 
overrite_file 
}

if [ $0 = $BASH_SOURCE ];then
set -o nounset
#set -e
steps
fi
