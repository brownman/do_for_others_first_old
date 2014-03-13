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
    #remove trailing
        cmd=$(echo "$cmd" | sed -e 's/^ *//g' -e 's/ *$//g');

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
set_validation2(){
    set_commented "validation2"
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
        set_commented "parser"

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

switch_std(){

    3>&1 1>&2 2>&3
   
}
test_std(){
 
switch_std
echo to_1 >&1
echo to_2 >&2

switch_std
echo to_1 >&1
echo to_2 >&2


}


ttt(){

        print_color_n 31 '[ttt]'
  #          breakpoint_line $LINENO
    
    if [ $# -gt 0 ];then
        local cmd="$@"

        echo -n  "[$cmd]"
        res=0

#switch_std
           [  eval "$cmd" 1>/tmp/1 2>&1 ]  && {  res=1; } || { res=0; }

#            switch_std
            echo "[res] $res" >&2
 if [ "$res" -eq 1 ];then
     reason_of_death "invalid command" "$cmd" 3
 fi
#{ echo >&2 "[ error ] $cmd"; reason_of_death "invalid command: " " $cmd"; }
    else
        reason_of_death "empty command" 
    fi

           sleep 4
#            http://unix.stackexchange.com/questions/42728/what-does-31-12-23-do-in-a-script
}

eat(){



    local max="${#arr_parser[@]}"
    for (( i=0; i<$max; i++ ))
    do
        #echo     "${arr_parser[i]}:${arr_line[i]}"
        script="${arr_parser[i]}" 
        line="${arr_line[i]}"

#        cmd="ls \"$script\""
        #    eval "$cmd"

        #breakpoint_line $LINENO
        # eval "$cmd" 1>/dev/null 2>&1   &&  echo >&2 reason_of_death 'invalid script' "$script" 

        #test "$cmd"

        #            eval "$cmd" >/dev/null 2>&1 && { echo >&2 "[ error ] $cmd"; reason_of_death "invalid command: " " $cmd"; } || { echo ok;} 
        #           sleep 10
        #            eval "$cmd" >/dev/null 2>&1 || { echo >&2 "[ error ] $cmd"; reason_of_death "invalid command: " " $cmd"; }
        #       echo "line: $LINENO" 
        #      echo "line: ${LINENO[0]}" 
        #          breakpoint_line

        #"${LINENO[0]}"
        if [ -n "$validation2" ];then
            cmd="type $validation2"
            ttt "$cmd"
            #          echo "$cmd"
            cmd="$validation2 $script"
            ttt "$cmd"
            #commander "$cmd"
            #reason_of_death 'invalid validation' "$validation" 

        fi

        if [ -n "$validation" ];then
            cmd="type $validation"
            ttt "$cmd"

            cmd="$validation $line"
            ttt "$cmd"
            #            eval "$cmd"
            res=$?
            if [ $res -eq 0  ];then

                cmd="$script $line"
                eval        "$cmd"

                res=$?
                if [ "$res" -eq 1 ];then
                    #                echo -n '[COMMAND] ' 
                    #                echo "$cmd"
                     echo "exited with an error:"
                    #                echo '[LISTER]'
                    exiting
                fi
            else 
                reason_of_death 'validation failed' "$cmd"
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
    set_validation2
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
