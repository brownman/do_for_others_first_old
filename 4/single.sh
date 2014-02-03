#!/bin/bash 
#set -u
show_my_name script

dir_self=`dirname $0`
#echo "5 is: $5"
#print_got "run.sh got: $@"
filename=''


#echo "$script"
#echo "${args[@]}"
#:argr "$dir_self $@"
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
show_scripts(){
    show_my_name func
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
    show_my_name func
    say_my_name
    print_error "please supply a script name (+-arguments)"
    #    show_dependencies
    show_history
    show_scripts
    reason_of_death 'no arguments'
}
run(){

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

if [ $# -eq 0 ];then
    print_note 'helping'
    help
else
    print_note 'running'
    dir="$dir_sh" 
    file_type='sh'
    arg_soft "$@"
    
    script="$dir/$script.$file_type"
    #updated script 

    run
fi



#echo vi $script
