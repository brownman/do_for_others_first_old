#!/bin/bash
pushd `dirname $0` >/dev/null
path=`dirname $0`

file_list="$path/list"
file_level="$path/level"

file_list_tmp=/tmp/file_list_tmp
grep -v '^#' $file_list > $file_list_tmp
let 'level=0'

str_to_arr(){
    #depend on: arr
    local str="$1"
    local delimeter=${2-'|'}
    IFS=$delimeter read -a arr <<< "$str"
    #result: arr
}

set_level(){
    str=`cat  $file_list | grep level: | sed 's/#level://g' | sed 's/ //g'`
    echo "$str"
    let "level=$str"
    echo -n "[efficiency level is:]  "
    sleep 1
    echo "$level "
    sleep 2
}
set_parser(){
    str=`cat  $file_list | grep parser: | sed 's/#parser://g'`
    echo "$str"
    parser="$str"

    echo -n "[parser is:]  "
    sleep 1
    #    echo "$parser"

    str_to_arr "$parser"
    arr_parser=( "${arr[@]}" )

    echo "[ ${#arr_parser[@]} ] ${arr_parser[@]}"
    sleep 2
}

set_line(){
    local    line="$1"
    echo -n "[line is:]  "
    sleep 1
    str_to_arr "$line"
    arr_line=( "${arr[@]}" )
#    echo "---[ ${arr_line[@]} ]---"
    sleep 2
}





eat(){
    print_func
    max="${#arr_parser[@]}"
    for (( i=0; i<$max; i++ ))
    do

        echo     "$1 [run] ${arr_parser[i]} | [args] ${arr_line[i]}"
        eval     " ${arr_parser[i]} ${arr_line[i]}"
        
    done


}


loop(){
    print_func
    while read line;do
        if [ "$line" ];then
            print_line
            set_line "$line"
            eat
        else
            reason_of_death 'empty line' "$line"
        fi
    done < $file_list_tmp 

}

steps(){
    set_level
    set_parser
    loop
}


steps
popd >/dev/null
