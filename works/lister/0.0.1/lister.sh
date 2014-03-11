#!/bin/bash 
echo '[LISTER]'
sleep 3
# braceexpand     on
# errexit         on
# hashall         on
# interactive-comments    on


#set -o nounset
#set -o errtrace
#set -o errexit
sleep 3
breakpoint(){

echo breakpoint

}
#trap breakpoint ERR
path_from=`pwd`
pushd `pwd` >/dev/null

path=$path_from
if [ "$#" -gt 0 ];then
    list_name=$1
else
    list_name=list
    #reason_of_death 'supply a file with tasks'
fi
#################################

########################## ARGS
cover(){
str=`    cat $1 | grep '(){'`
echo "available func: $str"
}

get_list(){
    file_list="$path_from/$list_name"
    if [ "$file_list"  ];then
        if [ -f "$file_list" ];then
        print_color_n 34 '[LIST]'
        echo "$file_list"
    else
        reason_of_death 'not a file' "$file_list" 
    fi
else
    reason_of_death 'supply a list of tasks'
    fi


}
create_tmp_list(){
    file_list_tmp=/tmp/file_list_tmp
    grep -v '^#' $file_list > $file_list_tmp
    let 'level=0'
}


str_to_arr(){
    #depend on: arr
    local str="$1"
    local delimeter=${2-'|'}
    IFS=$delimeter read -a arr <<< "$str"
    #result: arr
}

set_level(){
    str=`cat  $file_list | grep level: | sed 's/#level://g' | sed 's/ //g'`
    let "level=$str"
    print_color_n 32 "[EFFICIENCY] level is: "
    #sleep 1
    echo "$level "
    #sleep 2
}
set_parser(){
    str=`cat  $file_list | grep parser: | sed 's/#parser://g'`
    parser="$str"
    #sleep 1
    str_to_arr "$parser"
    arr_parser=( "${arr[@]}" )
    #sleep 2
}

set_line(){
    local    line="$1"
    #sleep 1
    str_to_arr "$line"
    arr_line=( "${arr[@]}" )
    #    echo "---[ ${arr_line[@]} ]---"
    #sleep 2
}





eat(){
    local max="${#arr_parser[@]}"
    for (( i=0; i<$max; i++ ))
    do
        #echo     "${arr_parser[i]}:${arr_line[i]}"
eval        "${arr_parser[i]} ${arr_line[i]}"
res=$?
if [ "$res" -eq 1 ];then
    exiting
fi
    done


}


loop(){
#    print_func
    let 'counter=1'
  let   "max=$level"

    while read line;do
        if [ $counter -eq $max ];then
#echo            breaking
            break
        fi
        echo -n '--------------------- '
        print_color 33 "..${counter}.."
        if [ "$line" ];then
            if [ "$counter" -le $max ];then


                #print_color 32 "[EAT]"
                set_line "$line"
                eat

                #print_line
            else
                print_color_n 31 "[SKIP] "
                echo "$line"
            fi
        else
echo reason_of_death 'empty line'
        fi
        let 'counter+=1'
    done < $file_list_tmp 

}

steps(){
    get_list
    create_tmp_list
    set_level
    set_parser
    loop
}


steps
popd >/dev/null