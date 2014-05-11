#!/bin/bash -x


clear
exec 2>/tmp/err
set -o nounset
trap  trap_err ERR

sourcing(){
    print_func
    local  file=$1
    source $file
}
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
eat(){
    echo eat
    print_func
    line=$1
    file="$dir_self/CFG/${line}.cfg"
    if [ -f "$file"  ];then
        num=`cat $file | wc -l`
        if [ $num -gt 0 ];then
            sourcing $file
            try $line 
        else
            print_color 31 "file is empty: " "$file"
            update_clipboard                "vi $file"

        fi
    else
        print_color 31 "file not exist: " "$file"
        update_clipboard                "vi $file"
    fi

}

tests(){
    ###text1
    print_func
        local counter=1
    while read line;do

        if [ -n "$line" ];then
            echo "[$counter]  $line "
            eat "$line"
        else
            echo -n "[_]"
        fi

        let 'counter += 1'
        #   (  "$line" )
    done<$file_list
    #    res=$?
    #    step $res 0

    ###test2


}
set_env(){
dir_self=`dirname $0`
    file_list=$dir_self/list.txt

}
steps(){
    #    type tests  | grep test_

set_env
    tests
}
steps
