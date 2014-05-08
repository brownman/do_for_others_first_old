#!/bin/bash
# about file:
# name:        ensure suspension!
# description:   separate the proccess running the suspend.sh

#notify_send 'ensure suspension'

args=( "$@" )
res=''
#notify_send1 'single.sh' "$@"
notify_send "$@"


run(){
#eval show_args
#update_commander

#notify_send3 'who make the loop'

#sleep1 2
#cmd='notify_send1 hi bye'
#cmd='tasker config update_commander'
#decide1 "$cmd"
res=$( tasker "${args[@]}" )
}
run
echo "$res"
