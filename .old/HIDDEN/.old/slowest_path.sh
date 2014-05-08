#!/bin/bash
set -o nounset
clear
file_script=$1


if [ ! -f "$file_script" ];then
    echo 'supply a script to wrap'    
    exit 1
fi


exports(){
    let 'max_lines=4'
}


checkk(){
    type $sh_wrapper 1>/dev/null 2>/dev/null
    res=$?
    echo "result: wrapper is active? " 
    echo "$res"
    sleep 3
    if [ "$res" -eq 0  ];then
        cmd="bash -c $sh_wrapper $file_script"
    else
        cmd="bash -c $file_script"
    fi
}

print_file00(){
    sleep 1
    file=$1
    echo '--'
    local max=`cat $file |  wc -l`
    echo "[ $file ] $max_lines / $max"
    if [ "$max" -gt 0 ];then
        echo
        if [ $max_line -lt $max ];then

            cat  $file | head -${max_lines}
        else
            cat $file
        fi
        echo '--'
    fi
}
export -f print_file00

run(){


    local  cmd="bash -c $file_script"
    ( eval "$cmd" 1>/tmp/out 2>/tmp/err )

}
#cmd="ls  /tmp/log/* | xargs print_file00"
#cmd="find /tmp/log -iname '*.txt' -exec print_file00 '{}' \;"
log(){


    print_file00 '/tmp/out'
    print_file00 '/tmp/err'

    IFS=$'\n'; for i in `find /tmp/log -iname '*.*'`; do print_file00 "$i"; done

}

steps(){
    exports
    run
    log

}

steps


#echo "$cmd"
#eval "$cmd"

echo END
set +o nounset

