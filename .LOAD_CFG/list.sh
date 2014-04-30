pending(){

print_color 34 "[PENDING]"
echo $@
}
0_trap_err(){
#_trap_err_simple(){
cat /tmp/err
go_home
}
1_trap_err(){
    #_show_error_line(){
    echo `caller`
cat /tmp/err
go_home
}
2_trap_err(){
    #_show_error_line(){
    str_caller=`caller`
cat /tmp/err
cmd="vi +${str_caller}"
eval "$cmd"
go_home
}

test_err(){
echo
}
smart_ass(){
echo show last log
    cat -n /tmp/log
    [ ! -s /tmp/err ] && { rm /tmp/err;echo removing /tmp/err; } 
    sleep 3
random 3
num_tmp=$?
cmd="trap ${num_tmp}_trap_err ERR"
echo $cmd
sleep 1
eval "$cmd"
[ -f /tmp/err ] && { echo rm /tmp/err;rm /tmp/err; }
exec 2>/tmp/err
test_err


}

set_runner(){
    echo $FUNCNAME

    export file_runner=${BASH_SOURCE:-$0}
    export dir_self=$( where_am_i $file_runner )

}
load_cfg(){
    sleep  2
    cat  $dir_self/env.cfg
    source $dir_self/env.cfg
    source $dir_self/traps.cfg
    alias firstE="gvim $file_runner"
    #[ "$MODE_TRAP_ERR" = true ] && step_set_trap
    #[ "$MODE_TTY" = true ] &&    step_tty_clear

}

loop(){
    #info: loop over a list of commands: 2 options: source_it/run_it
    #reason: list is wonderful but tearsome if not sourcing the library first
    echo "$FUNCNAME"
    local file_list=$dir_self/list.txt
    local counter=1
    while read line;do
        if [ -n  "$line" ];then
            #proxy   "toilet --gay  step ${counter}  " 
            echo $line
            echo
            #        proxy $line

            proxy "$line" 1>/tmp/log${counter}

            cp /tmp/log${counter} /tmp/log
#            $dir_self/LOG/$counter 

            #cat $dir_self/LOG/$counter >/dev/tty1
        else
#            echo -n "."

            echo breaking
            break
        fi
        let 'counter += 1'
    done < $file_list
}
steps (){
    ############### env

every 7 "set -x"
every 4 "set -e"

every 3 "exec 2>/tmp/err"
every 2 "set -o nounset"

shopt -s expand_aliases

#################### clean up

    set_runner
    loop
echo end


    #|| { echo no file /tmp/err; }
}
steps

