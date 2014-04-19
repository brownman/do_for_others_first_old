#!/bin/bash -e
set -o nounset
#. $file_trap
#info: robot + speech recognition
#details: everything is easy for the robot - and he knows many languages - let him deal with the hardest tasks
#set -o nounset
#_ __ ___ | |__   ___ | |_ 
#| '__/ _ \| '_ \ / _ \| __|
#| | | (_) | |_) | (_) | |_ 
#|_|  \___/|_.__/ \___/ \__|
#####################
#exec 2>/tmp/err
cat(){
    if [ $# -eq 1 ];then
        local file=$1
        if [ -f "$file" ];then
            local num_lines=$( cat $file  |  wc -l )
            #$( wc -l $file | cut -d' ' -f1 )
            if [ -s $file ] && [ $num_lines -gt 0 ];then
                local util=`which cat`
                eval "$util $file"
            else
                present print_color 31 "create file $file"
                gvim $file
            fi
        else
            present print_color 31 "[ERROR] cat() - needs only 1 argument: the target file"
        fi

    fi
}
print_func(){
    echo "${FUNCNAME[1]}"
}
intro(){
    clear
    echo '[robot]'
    echo '[ROBOT] ask for the smallest - but yet - possible'
    echo 'save your answers in a  snippet'
}

traps(){
    print_func
    echo traps
    #url:    http://stackoverflow.com/questions/64786/error-handling-in-bash
    local str="$1"
    echo "[ trap ] $str > $_ "
    case  "$str" in
        err)

            local cmd="gxmessage -file /tmp/err -title '[ trap ] err' -timeout $timeout"
            eval "$cmd"
            ;;
        *)
            echo 
            ;;
    esac

    say fail
}

set_env(){
    print_func

    dir_self=$( where_am_i $0 )
    file_recent=/tmp/recent.txt
    file_cmd_out=/tmp/out.txt
    file_cmd_res=/tmp/res.txt
    file_commands=/tmp/commands.txt
    #touch $file_commands
    #touch $file_recent

    dir_txt=/tmp
    #$dir_self/txt
    SMART=false
    timeout=20

}
set_traps(){
    #`dirname $0`
    trap traps err ERR
    trap traps sighup SIGHUP
    #ERR
    trap traps sigint SIGINT
    #ERR
    trap traps sigterm SIGTERM
    #ERR

}

proxy1(){
    local args=( $@ )
    local cmd="${args[@]}"
    echo "$cmd" >> $dir_txt/proxy.txt

    (    eval "$cmd" 2>/tmp/err 1>/tmp/out )
}

random_line(){
    echo 'random_line'
    local type="$1"
    local file=/tmp/${type}.txt
    if [ ! -s $file  ];then
        proxy xcowsay "create new file $file"
        gvim $file
    fi


    num=$(        cat $file | wc  -l )
    line=$( cat $file | tail -${num} | head -1 )
    echo "$line"

}
say(){
    print_func
    echo say
    #try to trigger the command in a sub-shell - then report the results with hopefully - a  smiling robot
    local type=$1
    local file=$dir_txt/${type}.txt 
    local            answer=$( random_line $file )
    flite "$answer"
}


search_db(){
    local     cmd="$@"
    print_func

    if [ "$SMART" = false ];then
        local     line=$( cat "$file_commands" | grep  -m 1 "$cmd" )
    else
        echo 'implement regex matching'
    fi
    return $?
}
try(){

    local cmd="$@"
    print_func
    #echo try

    search_db "$cmd"
    local res=$?
    if [ $res -eq 0 ];then
        found "$cmd"
    else
        #generate random response from the robot - based upon the clock mood
        say "$res"
    fi

}
found(){
    local line="$@"
    local text=$( echo "$line" | cut -d'#' -f1 )      
    local text_ws=$( echo "$text" | sed 's/ /_/g' )
    local cmd=$( echo "$line" | cut -d'#' -f2 )      
    local file_cmd_out=/tmp/${text_ws}
    if [ -s "$file_cmd_out" ];then
        #show the latest results for this command
        local cmd_new=$( gxmessage -entrytext "$cmd" -file $file_cmd_out -timeout $timeout -title "$text" )
    else
        local cmd_new=$( gxmessage -entrytext "$cmd" "$text" -timeout $timeout )
    fi

    #evaludate in sub-shell

    echo "[running in sub-shell] $cmd_new"
     eval "$cmd_new" 
     #1>$file_cmd_res 2>/tmp/err 

}

loop(){
    print_func
    echo '[ loop ]'
    proxy "flite -t 'the robot thinks - it is easy - try him - and correct him'"

    local str_robot_ask=''
    while :;do
        local cmd="gxmessage -timeout $timeout -file $file_recent -title 'imagine easiness - how is it really?' -entrytext \"$str_robot_ask\""

        local str_robot_ask=$( random_line intro )
        local    answer=$( eval "$cmd" )
        if [ "$answer" = exit ];then
            echo breaking
            break;
        else
proxy            sleep 1
           try "$answer"
        fi
proxy sleep 1
    done
}
steps(){
    print_func
    intro
    set_env
    #sdf
    #print_env
    loop
}
steps
