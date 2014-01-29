#!/bin/bash -e


#export dir_base=`pwd` #mistake  ! doesn't  work with hotkeys..


#path=`pwd`
path=`dirname $0`
export dir_base=$path #mistake  ! doesn't  work with hotkeys..

source $dir_base/cfg/struct.cfg 
source $dir_cfg/colors.cfg 
source $dir_cfg/bashrc.cfg 

source $dir_cfg/vars.cfg 
source $dir_cfg/funcs.cfg 


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
    cat $path/.history | tail -$tail
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
    sleep1 2
#    show_dependencies
    show_history
    show_options
    exit
}
run(){
    script="$dir_sh/$filename.sh" 
    if [ -f "$script" ];then
        #save command to history
        echo "$script]] ${args[@]}" >> $path/.history
        #execute
        cmd="$script ${args[@]}"
        print_call "call: $cmd"
        eval "$cmd" 
    else
        print_error "file not found: $script"
        eval  exiting
    fi
}


if [ "$filename"  ];then
    run
else
    help
fi

#echo vi $script
