#!/bin/bash
pushd `dirname $0` >/dev/null
path=`dirname $0`

file_list="$path/list"
file_level="$path/level"
let 'level=0'

set_level(){
    str=`cat  level`
    let "level=$str"
    echo -n "[efficiency level is:]  "
    sleep 1
    echo "$level "
    sleep 2
}
parse(){
    print_func
    desc=`echo $line | cut -d'|' -f1 `
    action=`echo $line | cut -d'|' -f2 `
    echo -n '[Desc] '
    echo "$desc"
    echo -n '[Act]  '
    echo "$action"
    eval "$action"
}


loop(){
    print_func
    while read line;do
        parse "$line"
    done < $file_list
}

steps(){
    set_level
    loop
}


steps
popd >/dev/null
