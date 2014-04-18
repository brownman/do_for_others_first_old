#!/bin/bash
#info: everything is easy for the robot - and he knows many languages - let him deal with the hardest tasks
#set -o nounset
#_ __ ___ | |__   ___ | |_ 
#| '__/ _ \| '_ \ / _ \| __|
#| | | (_) | |_) | (_) | |_ 
#|_|  \___/|_.__/ \___/ \__|
#####################
#exec 2>/tmp/err
intro(){
clear
echo '[robot]'
echo '[ROBOT] ask for the smallest - but yet - possible'
echo 'save your answers in a  snippet'
}

traps(){
    print_func
#url:    http://stackoverflow.com/questions/64786/error-handling-in-bash
    local str=$1
    echo "[ trap ] $str > $_ "
    case in $str;
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
    dir_self=$( where_am_i )
    dir_txt=$dir_self/txt
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

}
say(){
    print_func
    echo say
    #try to trigger the command in a sub-shell - then report the results with hopefully - a  smiling robot
    local type=$1
    local file=$dir_txt/${type}.txt 
    local num_lines=$( wc -l $file | cut -d' ' -f1 )
    [ -s $file ] && [ $num_lines -gt 0 ] || { gvim $file; }
    local            answer=$( random_line )
    flite "$answer"
}


search_db(){
    print_func
    if [ "$SMART" = false ];then
        local     line=$( cat "$file_commands" | grep  -m 1 "$cmd" )
    else
        echo 'implement regex matching'
    fi
    return $?
}
try(){
    print_func
    echo try
    local cmd="$@"
    search_db
    local res=$?
    if [ $res -eq 0 ];then
        found
    else
        #generate random response from the robot - based upon the clock mood
        say "$res"
    fi

}
found(){
print_func
    local text=$( echo "$line" | cut -d'#' -f1 )      
    local text_ws=$( echo "$text" | sed 's/ /_/g' )
    local cmd=$( echo "$line" | cut -d'#' -f2 )      
    local file_cmd_out=/tmp/${text_ws}
    if [ -s "$file_res" ];then
        #show the latest results for this command
        local cmd_new=$( gxmessage -entrytext "$cmd" -file $file_cmd_out -timeout $timeout -title "$text" )
    else
        local cmd_new=$( gxmessage -entrytext "$cmd" "$text" -timeout $timeout )
    fi

    #evaludate in sub-shell

    echo "[running in sub-shell] $cmd_new"
    ( eval "$cmd_new" 1>$file_cmd_res 2>/tmp/err )

}

loop(){
    print_func
    echo '[ loop ]'
    proxy "flite -t 'the robot thinks - it is easy - try him - and correct him'"

    while :;do
        local cmd="gxmessage -timeout $timeout -file $dir_self/recent.txt -title 'imagine easiness - how is it really?' -entrytext \"$str_robot_ask\""

        local str_robot_ask=$( random_line intro )
        local    answer=$( eval "$cmd" )
        if [ "$answer" = exit ];then
            echo breaking
            break;
        else
            try "$answer"
        fi

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
