#!/bin/bash

set -o nounset
clear

echo SHLVL $SHLVL
exec 2>/tmp/err
trap_err(){
    print_line
    print_color 34 "$FUNCNAME"
    cat /tmp/err
    echo
    echo
    exit 0
}


check(){
    [ "$1" = "$2" ] 
}
print_status(){
    num=$1
    [ $num -eq 0 ] && { print_color 32 "[V]"; } || { print_color 31 "[X]"; }
}


assertEquals(){
    check "$1" "$2"
    res=$?
    print_status $res
    [ $res -eq 1 ] && { return 1; }
}



try(){
local func=$1
 print_line
 ( $func )
 print_line
 assertEquals $? 0
            
}

tests(){
    ###text1
    dir_self=`dirname $0`
    file_list=$dir_self/list.txt
    while read line;do
        if [ $line ];then
            echo "[test]  $line "
            file="$dir_self/CFG/${line}.cfg"
            if [ -s "$file"  ];then
source $file
                try $line 
            else
                print_color 31 "file not exist: " "$file"
                local  cmd="touch $file"
                echo create new file ?  
                echo "[ $file ] "
                print_color 32 " OK ! " 
                eval "$cmd"
update_clipboard                "vi $file"
            fi
        fi
        #   (  "$line" )
    done<$file_list
    #    res=$?
    #    step $res 0

    ###test2


}

steps(){
    #    type tests  | grep test_

    trap  trap_err ERR
    tests
}
steps
