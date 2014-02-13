#!/bin/bash
confirm
print_script
#dir_self=`dirname $0`
#filename=''

show_scripts(){
    print_func
    # local type=${1:-sh}
    local dir="$dir_plugins"
    #   echo "dir plugins: $dir"
    if [ -d $dir ];then
        print  print_good "show available plugins:"
        #    local ptrn="s/.$type//g"
        ls -1 $dir 
        echo
        #| sed "$ptrn"
    else
        reason_of_death 'no such directory' "$dir"
    fi
}

help(){
    print_func
    #    say_my_name
    #    print_error "please supply a script name (+-arguments)"
    show_scripts
    reason_of_death 'no arguments'
}
run(){
    print_func
    cmd_edit="$EDITOR $script"
#    update_clipboard "$cmd_edit"
    if [ -f "$script" ];then
        cmd="$script ${args[@]}"
        print    print_call "call: $cmd"
        commander "$cmd" 
    else
        reason_of_death 'file not found' "$script"
        exit 1
    fi
}

if [ $# -eq 0 ];then
    echo 'helping..'
    confirm
    help
else
    echo 'running..'
    confirm
    dir="$dir_plugins" 
    name=$1
    shift
    if [ $# -gt 1 ];then
        args=( "$@" )
    fi
    echo testing..
    #$dir_plugins/$name/test.sh
    #res=$?
    res=1
    if [ $res -eq $SUCCESS ];then
        if [ "${#args[@]}" -gt 0 ]
            $dir_plugins/$name/$name.sh "${args[@]}"
        else
            $dir_plugins/$name/$name.sh
        fi
    else
        reason_of_death 'test failed'
    fi

fi
#file_type='sh'
#arg_soft "$@"
#script_name=$script
#script="$dir/$script_name/$script_name.$file_type"
#run



