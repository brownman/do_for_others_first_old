#!/bin/bash -x 
#info: parse a list of cetain types which determined by the commented part

every 4 "set -o nounset"
. $dir_root/.file_quick_trap.cfg
path=`pwd`
proxy echo "path is : $path"
pushd "$path">/dev/null
#cmd="set -o nounset"
#set_path(){
#path=${path:-"$PWD"}
#path_self=`dirname $0`
#}


reason_of_death(){
echo "reason of death"
echo "why: ${1:-''}"
echo "who: ${2:-''}"
echo exiting
exit
}


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
get_list(){
    

    if [ "$file_list"  ];then
        if [ -f "$file_list" ];then
            proxy present print_color_n 34 '[LIST] '
            echo "$file_list"
        else
            proxy "reason_of_death 'not a file' \"$file_list\"" 
        fi
    else
        reason_of_death 'supply a list of tasks'
    fi


}



set_commented(){
    local subject="$1"
local cmd="cat  $file_list | grep \"$subject:\" "
local str_res=$( proxy "$cmd" )
echo "subject: $subject ,res: $str_res "
go_home
#    local     str=$( )
    #| sed \"s/#${subject}: //g\" )
#echo "$str"
return
    #remove trailing
    cmd1=$(eval "$cmd" | sed -e 's/^ *//g' -e 's/ *$//g');
    #| sed 's/ //g'"
    #echo "$cmd"
    str=$( eval "$cmd1" )
    #    echo -n "str:"
    #   echo "$str"

    #   proxy print_line

    cmd2="$subject=$str"
#    echo "$cmd"
    eval "$cmd2"
    echo -n "[SET_COMMENTED]" 
    echo -en "\t [ $subject ]"
    echo -e "\t$str"

}
set_validation(){
    print_func
    set_commented "validation"
}
set_validation2(){

    print_func
    set_commented "validation2"
}

set_level(){
    print_func
    set_commented "level"
}


#set_level1(){
#   str=`cat  $file_list | grep level: | sed 's/#level://g' | sed 's/ //g'`
#   let "level=$str"
#    proxy print_color_n 32 "[EFFICIENCY] level is: "
#sleep 1
#   echo "$level "
#sleep 2
#}
set_arr_parser(){

    print_func
    set_commented "parser"

    #sleep 1
    str_to_arr "$parser" '|'

    arr_parser=( "${arr[@]}" )
    num="${#arr[@]}"
    echo '[PARSER]'
    #    echo "run $num commands on every item from the list"
    #sleep 2
}

set_arr_line(){

    print_func
    local    line="$1"
    #sleep 1
    str_to_arr "$line"
    arr_line=( "${arr[@]}" )
    #    echo "---[ ${arr_line[@]} ]---"
    #sleep 2
}

switch_std(){

    print_func
    3>&1 1>&2 2>&3

}
test_std(){

    print_func
    switch_std
    echo to_1 >&1
    echo to_2 >&2

    switch_std
    echo to_1 >&1
    echo to_2 >&2


}


ttt(){

    print_func
#echo -ne  "\t"
    #          breakpoint_line $LINENO

    if [ $# -gt 0 ];then
        local cmd="$@"

        #  echo -n "[ cmd ] "
          echo -e "\t$cmd"
        let 'res=0'

        #switch_std
        `eval "$cmd" 1>/tmp/out 2>/tmp/err`

        #1>/tmp/1 2>&1 
        res=$?
        #{ let 'res=1';notify-send 1; } || { let 'res=0';notify-send 0; }
        #{  res=1; } || { res=0; }

        #            echo "[res] $res" >&2

        #          sleep 4


        #            switch_std



        if [ "$res" -eq 1 ];then
            echo -n '[err] '
            cat /tmp/err  | head -1
            reason_of_death "test failed" "$cmd" 2
        else
            cmd0='echo -n [out] '
            cmd='cat /tmp/out  | head -1'
            every 10 "$cmd0;$cmd" 'trace [SKIP] presenting /tmp/out'

        fi
        #{ echo >&2 "[ error ] $cmd"; reason_of_death "invalid command: " " $cmd"; }
    else
        reason_of_death "empty command" 
    fi

    #            http://unix.stackexchange.com/questions/42728/what-does-31-12-23-do-in-a-script
}

eat(){


    print_func

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
                                    echo -n '[COMMAND] ' 
                                    echo "$cmd"
                    echo "exited with an error:"
                                    echo '[LISTER]'
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

    print_func
    #    proxy print_func
    let 'counter=1'
    local max="$level"

    while read line;do
        if [ $counter -eq $max ];then
            #echo            breaking
            break
        fi
        echo -n '--------------------- '
        proxy print_color 33 "..${counter}.."
        if [ "$line" ];then
            if [ "$counter" -le $max ];then
                proxy print_color 32 "[EAT]" "$line"
                set_arr_line "$line"
                eat
                #proxy print_line
            else
                proxy print_color_n 31 "[SKIP] "
                echo "$line"
            fi
        else
            warning 'empty line'
        fi
        let 'counter+=1'
    done < $file_list_tmp 

}
sets(){

    print_func

    set_commented "level"
# proxy   set_validation
# proxy   set_validation2
#proxy    set_arr_parser

}
steps(){

    print_func
 proxy   get_list
  proxy   create_tmp_list
proxy sets    
proxy    loop
}
############################################################### start
if [ "$#" -gt 0 ];then
    #args
    file_list="$1"
proxy     assert file_has_content "$file_list"
    #info: clean file - rm  the commented lines 
    file_list_tmp=/tmp/file_list_tmp
    grep -v '^#' $file_list > $file_list_tmp
    #get some indication
    let level=$(    cat $file_list_tmp | wc -l )
else
    reason_of_death 'supply a file with tasks'
fi

popd>/dev/null
