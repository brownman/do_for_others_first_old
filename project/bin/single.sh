#!/bin/bash 
print_script

dir_self=`dirname $0`
filename=''

show_scripts(){
  print_func
    local type=${1:-sh}
    local dir="${2:-$dir_plugins}"
if [ -d $dir ];then
    print_good "show available scripts:"
    local ptrn="s/.$type//g"
    ls -1 $dir | sed "$ptrn"
else
    reason_of_death 'no such directory' "$dir"
fi
}

help(){
    print_func
    say_my_name
    print_error "please supply a script name (+-arguments)"
    show_scripts
    reason_of_death 'no arguments'
}
run(){
    print_func
#cmd_edit="$EDITOR $script_name/$script_name"
#xsel "$cmd_edit"
    if [ -f "$script" ];then
        cmd="$script ${args[@]}"
        print_call "call: $cmd"
        eval "$cmd" 
    else
        reason_of_death 'file not found' "$script"
        exit 1
    fi
}

if [ $# -eq 0 ];then
    print_note 'helping'
    help
else
    print_note 'running'
    dir="$dir_plugins" 
    file_type='sh'
    arg_soft "$@"
    script_name=$script
    script="$dir/$script_name/$script_name.$file_type"
    run
fi



