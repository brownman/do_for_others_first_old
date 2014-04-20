#!/bin/bash 
#every 4 'set -x'
#set -o nounset
#. $file_trap
#info: robot + speech recognition
#details: everything is easy for the robot - and he knows many languages - let him deal with the hardest tasks
#set -o nounset
#_ __ ___ | |__   ___ | |_ 
#| '__/ _ \| '_ \ / _ \| __|
#| | | (_) | |_) | (_) | |_ 
#|_|  \___/|_.__/ \___/ \__|
#####################

echo exec 2>/tmp/err
safe(){
proxy    present print_color_n 35 "[SAFE]  "
    local act=$1
    echo "$act"

    case $act in
        start)
cmd="backup_steps"
echo "$cmd"
eval "$cmd"
        echo
        ;;
    finish)
        echo
[ -s /tmp/proxy ] && { tail -1 /tmp/proxy; }
[ -s /tmp/err ] && { cat /tmp/err; }
        ;;
    *)
        proxy present print_color 31 '[ERROR] invalid option: $act'
        echo zzzz
        ;;
esac
}
trigger(){
    local args=( $@ )
    local cmd="${args[@]}"
    echo $cmd
}
cat(){
    if [ $# -eq 1 ];then
        local file=$1

        local util=`which cat`
        if [ -f "$file" ];then
            local num_lines=$( $util $file  |  wc -l )
            #$( wc -l $file | cut -d' ' -f1 )
            if [ -s $file ] && [ $num_lines -gt 0 ];then

                eval "$util $file"
            else
                present print_color 31 "create file $file"
                gvim $file
            fi
        else
            #     present print_color 31 "[ERROR] cat\(\) - needs only 1 argument: the target file"

            gvim $file
            echo ERROR  - need 1 arg


        fi

    fi
    go_home
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
traps(){
    present print_color 31 "trap [code]$? [args]$@ "
    proxy sleep 2
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


random_line(){
    echo 'random_line'
    local type="$1"
    local file=/tmp/${type}.txt


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
    local file="$file_cmd_out"
#update params
local title="$text"
local entrytext="$cmd"

    if [ -s "$file" ];then
        #show the latest results for this command
#        local cmd_new=$( gxmessage -entrytext "$cmd" -file $file_cmd_out -timeout $timeout -title "$text" )
cmd_new=$( gxmessage_file "$file" "$title" "$entrytext" )
    else
 #       local cmd_new=$( gxmessage -entrytext "$cmd" "$text" -timeout $timeout )
 cmd_new=$( gxmessage_text "$text"  "$title" "$entrytext" )
    fi

    #evaludate in sub-shell

    echo "[later run in sub-shell] $cmd_new"
    trigger "$cmd_new" 
    #1>$file_cmd_res 2>/tmp/err 

}
uuu
loop(){
    print_func
    echo '[ loop ]'
    echo     proxy "flite -t 'the robot thinks - it is easy - try him - and correct him'"

    local str_robot_ask=''
    local file=$file_recent
    while :;do
        #cat $file        
        assert file_has_content "$file"
#        local cmd="gxmessage -timeout $timeout -file $file -title 'imagine easiness - how is it really?' -entrytext \"$str_robot_ask\""
local title="imagine easiness"
local entrytext="$str_robot_ask"
gxmessage_file "$file" "$title" "$entrytext"
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
        break
    done
}

steps(){

    print_func

    safe start
    set_traps
    intro
    set_env
    loop
    safe finish
}
steps
