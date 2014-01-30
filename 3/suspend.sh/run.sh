#!/bin/bash
dir_base=$PWD
path=$dir_base
dir_self=`dirname $0`
source $dir_base/cfg/suspend.sh/cfg/struct.cfg
source $dir_base/cfg/suspend.sh/cfg/colors.cfg
source $dir_base/cfg/suspend.sh/cfg/vars.cfg
source $dir_base/cfg/suspend.sh/cfg/funcs.cfg
source $dir_base/cfg/suspend.sh/cfg/sleep.cfg
print_got "run.sh got: $@"
filename=''
args=()
if [ "$1" ];then
    filename=$1
    if [ "$2" ];then
    shift
        args=( "$@" )
    fi
fi
tail=7


show_history(){
    #2>&1 | tee -a $path/.log/errors.log)
    print_good "show history (+$tail):"
#    cat $path/.history | tail -$tail
    echo "$dir_sh"
}

show_dependencies(){
    cat $dir_debian/control
}
show_options(){
    local type=${1:-sh}
    local dir=${2:-$dir_sh}
    print_good "show available scripts:"

    local ptrn="s/.$type//g"
    ls -1 $dir | sed "$ptrn"

}
show_edit(){
    print_status 'enter file to edit:'
    read answer
    line sh $answer
}

help(){
    print_error "please supply a script name (+-arguments)"
#    show_dependencies
    show_history
    show_options
    exit
}
run(){
    script="$dir_self/sh/$filename.sh" 
    if [ -f "$script" ];then
        #save command to history
#        echo "$script]] ${args[@]}" >> $path/.history
        #execute
        cmd="$script ${args[@]}"
        print_call "call: $cmd"
        eval "$cmd" 
    else
        print_error "file not found: $script"
    #    eval  exiting
    exit 1
    fi
}


if [ "$filename"  ];then
    run
else
    help
fi

#echo vi $script
