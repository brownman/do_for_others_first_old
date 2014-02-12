#!/bin/bash
# about file:
# name:        ensure I have only 1 reason to act and not many !



notify_send1 'one task:'  "$1"
#file_locker=/tmp/one_task
#delay=6

args="$1"
run(){
    local num="$args"
        local cmd="tasker task_from hotkeys $num"
        eval "$cmd"
}


run

