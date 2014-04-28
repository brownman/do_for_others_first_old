#!/bin/bash 
# about file:
# choose a workflow , run serial.sh
file_locker=/tmp/timer
delay=30

export DEBUG=${2:-false}


run(){
    local count1=0
    while :;do
        let "count1=count1+1"
        notify_send3 "wow! cycles: $count1"
        if [ "$DEBUG" = false ];then
            #tasker motivation glossary 
            trace ''
        fi
        run_workflow
        #cmd='tasker motivation koan'
        #every  "$cmd" 
        #force_koan 
        #cmd='tasker resources'
        #every "$cmd"
        #reload_cfg
    done
}


run_workflow(){
    sleep1 2
    $SCRIPT_DIR/more/serial.sh read_lines 
}
unlocker


