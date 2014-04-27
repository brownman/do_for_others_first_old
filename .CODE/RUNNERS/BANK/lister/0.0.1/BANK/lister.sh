#!/bin/bash  
clear
set -o nounset
#info: parse a list of cetain types which determined by the commented part
path=`pwd`

pushd "$path">/dev/null
#declare -A arr_line

arr_line=()
arr_parser=()
#declare -A arr_parser

reason_of_death(){
    echo "reason of death"
    echo "why: ${1:-''}"
    echo "who: ${2:-''}"
    echo exiting
    exit
}



#cmd="set -o nounset"
#set_path(){
#path=${path:-"$PWD"}
#path_self=`dirname $0`
#}


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
    print_func
    if [ -f "$file_list"  ];then
        if [ -f "$file_list" ];then
            #            type proxy
#            proxy present print_color_n 34 "LIST.." 
            #proxy present pv list
            #print_color_n 34 LIST 
            echo "$file_list"
        else
            reason_of_death 'not a file' $file_list 
        fi
    else

        reason_of_death 'supply a list of tasks'
    fi


}

remove_trailing(){
    #remove trailing
    cmd1=$(eval "$cmd" | sed -e 's/^ *//g' -e 's/ *$//g');

}

set_commented(){

    echo -n "[SET_COMMENTED] " 
    local subject="$1"
    #set -x
    #    print_func

    local cmd="cat  $file_list | grep $subject | sed 's/#$subject: //g'"
    #sed "s/#level: //g" 
    local str_res=$( proxy  $cmd )
    #echo "subject: $subject ,res: $str_res "
    #go_home
    #    local     str=$( )
    #| sed \"s/#${subject}: //g\" )
    #echo "$str"
    #| sed 's/ //g'"
    #echo "$cmd"
    #
    #str=$( eval "$cmd1" )
    #    echo -n "str:"
    #   echo "$str"

    #   proxy print_line

    if [ -n "$str_res" ];then
        echo -en "\t [ $subject ]"
        echo -e "\t$str_res"

        local cmd2="export $subject='$str_res'"
        #    echo "$cmd"
        echo "$cmd2"
        proxy "$cmd2"
    else

        echo gvim ${file_list} 
        reason_of_death 'tag has no value ' "$subject"
    fi

    #set +x

}


#set_level1(){
#   str=`cat  $file_list | grep level: | sed 's/#level://g' | sed 's/ //g'`
#   let "level=$str"
#    proxy print_color_n 32 "[EFFICIENCY] level is: "
#sleep 1
#   echo "$level "
#sleep 2
#}
set_arr_tmp(){
    local tmp="$1"
#    print_func
    local var="\$$tmp"
    local content=$( eval echo $var )
 #   go_home
    echo "[set array for ] tmp > $tmp"
    echo "[set array for ] var > $var"
    echo "[set array for ] content > $content"
    if [ -n "$content" ];then
        #print_func
        #set_commented "parser"
        #sleep 1
#        declare -a arr
       # =()
#        echo str_to_arr "$content" 
  #      go_home
        str_to_arr "$content" 
        

#        cmd="export arr_${tmp}='$arr_${tmp}'"
 #       echo proxy "$cmd"
        num="${#arr[@]}"
       # echo "[ arr ( $num ) ] ${arr[@]}"

eval  "export arr_${tmp}=( \"${arr[@]}\" )"
local var_res="\${arr_${tmp}[@]}"
echo "var_res: $var_res"
eval echo "$var_res"
        #echo 
        #cmd="
        

       # "
#echo proxy present        print_color 31  "$cmd"
       # echo  "$cmd"
       # eval "$cmd"
        
     #   echo "${arr_line[@]}"
    #|| {          echo "${arr_parser[@]}" ; }
#echo "${arr_$\{tmp\}[@]}"
        #    echo '[tmp]'
        #    echo "run $num commands on every item from the list"
        #sleep 2
    else
        reason_of_death 'var is not set' "$var"

    fi
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
    breakpoint_line $LINENO

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
            reason_of_death "test failed" "$cmd" 
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
validate(){
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
    else
        reason_of_death "empty tag: validation"
    fi


}
eat(){

    local max="${#arr_parser[@]}"

    print_func
    echo "max is $max"
    go_home
    for (( i=0; i<$max; i++ ))
    do
        #echo     "${arr_parser[i]}:${arr_line[i]}"
        echo "[focus] $i"
        script="${arr_parser[i]}" 
        line="${arr_line[i]}"
    
       # if [ $res -eq 0  ];then
#  else 
#            reason_of_death 'validation failed' "$cmd"
#        fi

           local cmd="$script $line"
            echo "[running] $cmd"
            proxy        "$cmd"
            res=$?
            if [ "$res" -eq 1 ];then
                echo -n '[COMMAND] ' 
                echo "$cmd"
                echo "exited with an error:"
                echo '[LISTER]'
                exiting
            fi
      
    done
}

#present_array(){
#local str=$1
#echo \$\{\$str\[\@]}
#}
loop(){

    print_func
    #    proxy print_func

   line_breakpoint 
    array_print arr_parser

    local counter=0
    local max=$level
    while read line;do
#        echo -n '--------------------- '
        #proxy present print_color 33 "..${counter}.."

            if [ $counter -le $max ];then
        if [ -n "$line" ];then



        print_color 32 $counter
print_color 33  "line: $line"
#echo                 proxy print_color 32 "[EAT]" "$line"
#arr_line=()
                set_arr_tmp "line"
                
                echo "line.size: ${#arr_line[@]}"
               # echo should eat now
               # echo eat
                #proxy print_line
        #    else
                #proxy print_color_n 31 "[SKIP LINE] "
                #echo "$line"
#                echo $counter
         #       echo 'skipping'

        else
        echo    warning 'empty line'
        fi
    else
        echo counter larger than max
            fi
        let 'counter+=1'
    done < $file_list_tmp 

}
sets(){

    print_func

    set_commented "level"
    #set_commented "validation"
    #set_commented "validation2"
    set_commented "parser"

    set_arr_tmp parser

}
steps(){
    print_func
    #get_list

    sets    
    loop
}
############################################################### start
if [ "$#" -gt 0 ];then
    #args
    #quick_rollet
    every 3 'set -o nounset'

    every 13 'set -x'

    every 3 'set -e'

    #proxy echo "path is : $path"

    #. $dir_root/.000_file_quick_trap.cfg

    file_list=${1:-"$dir_root/.list.txt"}
    assert file_has_content "$file_list"
    #info: clean file - rm  the commented lines 
    file_list_tmp=/tmp/file_list_tmp
    grep -v '^#' $file_list > $file_list_tmp
    #get some indication
#echo     let level=$(    cat $file_list_tmp | wc -l )
    steps
else
    reason_of_death 'supply a file with tasks'
fi

popd>/dev/null
