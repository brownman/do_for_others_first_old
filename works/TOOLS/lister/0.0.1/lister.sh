#!/bin/bash 

set -o nounset
#set -o pipefail




path=${path:-"$PWD"}
path_self=`dirname $0`
pushd "$PWD">/dev/null
echo '[LISTER]'
#sleep 3
# braceexpand     on
# errexit         on
# hashall         on
# interactive-comments    on


#set -o nounset
#set -o errtrace
#set -o errexit
#sleep 3
#################################

########################## ARGS
cover(){
    str=`    cat $1 | grep '(){'`
    echo "available func: $str"
}
export(){
    file_list="$path/$list_name"
    file_list_tmp=/tmp/file_list_tmp
}
get_list(){

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
set_commented(){
    local subject="$1"

    cmd="cat  $file_list | grep \"$subject:\" | sed \"s/#${subject}: //g\" "
    #| sed 's/ //g'"
    #echo "$cmd"
    str=$( eval "$cmd" )


#    echo -n "str:"
 #   echo "$str"

 #   print_line

    cmd="$subject=$str"
    echo "$cmd"
    eval "$cmd"
    print_color_n 32 "[$subject] is: "
    echo "$str"



}
set_validation(){
    set_commented "validation"
}
set_level(){
    set_commented "level"
}


#set_level1(){
 #   str=`cat  $file_list | grep level: | sed 's/#level://g' | sed 's/ //g'`
 #   let "level=$str"
#    print_color_n 32 "[EFFICIENCY] level is: "
    #sleep 1
 #   echo "$level "
    #sleep 2
#}
set_parser(){
    str=`cat  $file_list | grep parser: | sed 's/#parser://g'`
    parser="$str"
    #sleep 1
    str_to_arr "$parser"

    arr_parser=( "${arr[@]}" )
    num="${#arr[@]}"
    echo '[PARSER]'
#    echo "run $num commands on every item from the list"
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
        script="${arr_parser[i]}" 
        file="${arr_line[i]}"
           type $script 1>/dev/null 2>&1   &&  reason_of_death 'invalid script' "$script" 

#       echo "line: $LINENO" 
 #      echo "line: ${LINENO[0]}" 
#          breakpoint_line

          #"${LINENO[0]}"
        if [ -n "$validation" ];then
           cmd="type $validation"
 #          echo "$cmd"


 
            eval "$cmd" >/dev/null 2>&1 || { echo >&2 "[ error ] $cmd"; reason_of_death "invalid command: " " $validation"; }

#commander "$cmd"
breakpoint_line $LINENO
                     #reason_of_death 'invalid validation' "$validation" 
            cmd="$validation $file"
            eval "$cmd"
            res=$?
            if [ $res -eq 0  ];then

                cmd="$script $file"
                eval        "$cmd"

                res=$?
                if [ "$res" -eq 1 ];then
                    #                echo -n '[COMMAND] ' 
                    #                echo "$cmd"
                    # echo "exited with an error:"
                    #                echo '[LISTER]'
                    exiting
                fi
            else 
                reason_of_death 'not a file' "$file"
            fi
        else
            reason_of_death "empty tag: validation"
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
                print_color 32 "[EAT]" "$line"
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
    export
    get_list
    create_tmp_list

    set_level
    set_validation
    set_parser
    loop
}

if [ "$#" -gt 0 ];then
    list_name=$1
else
    list_name=list
    #reason_of_death 'supply a file with tasks'
fi
steps

popd>/dev/null
