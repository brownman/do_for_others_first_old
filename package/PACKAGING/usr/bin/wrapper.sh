#!/bin/bash -e

#version:   0.0.1
#date:      12.2.2014
#help:      run and save error logs
#arguments: a script to run
path=`pwd`
file_self=$path/self.cfg
source $file_self


breakpoint(){
flite "found error" 
}

trap breakpoint ERR
run(){
    print_func
    $( eval "$cmd" 2> ~/Desktop/ERRORS.txt )
}

if [ $# -gt 0 ];then
    cmd="$1"
    echo "run: $cmd"
    run
else
    echo
    echo 'No Arguments'
    show_self
fi
