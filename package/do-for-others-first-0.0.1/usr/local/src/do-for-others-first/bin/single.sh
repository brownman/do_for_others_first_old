#!/bin/bash -x
#print_script
#dir_self=`dirname $0`
#filename=''

show_scripts(){
    print_func
    # local type=${1:-sh}
    local dir="$dir_plugins"
    #   echo "dir plugins: $dir"
    if [ -d $dir ];then
        print_color $GREEN "available plugins:"
        #    local ptrn="s/.$type//g"
        ls -1 $dir 
        echo
        echo -n "example: "
        echo "./breath.sh gmail-group"
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
    #reason_of_death 'no arguments'
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
echo start
num=$#
if [ $num -eq 0 ];then
    echo "helping.."
    help
else
    echo running..
    dir="$dir_plugins" 
    name=$1
    shift
    if [ $# -gt 0 ];then
        args=( "$@" )
    fi
    if [  -d "$dir_plugins/$name" ];then

        export file_test=$dir_plugins/$name/test.sh
        export file_script=$dir_plugins/$name/script.sh
        export file_config=$dir_plugins/$name/config.cfg


        if [ -f "$file_test" ];then
            res=$FAILURE
            echo testing..

                source $file_config
            $file_runner $file_test
            res=$?
            if [ $res -eq $SUCCESS ];then
                print_color $GREEN 'test OK'

                if [ "${#args[@]}" -gt 0 ];then
                    $file_script "${args[@]}"
                else
                    $file_script
                fi
            else
                print_color $RED 'test failed'
            fi
        else
            reason_of_death 'no such test' "$file_test"
        fi
    else
        reason_of_death 'no such plugin' "$name"
    fi


fi

#file_type='sh'
#arg_soft "$@"
#script_name=$script
#script="$dir/$script_name/$script_name.$file_type"
#run


