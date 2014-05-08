#!/bin/bash -e
# about file:
# name:        ensure I have only 1 reason to act and not many !



notify_send 'one task:'  "$1"
#file_locker=/tmp/one_task
#delay=6

args="$1"
run(){
    local num="$args"
    local cmd="tasker task_from crons $num"
    eval "$cmd"
}


run

