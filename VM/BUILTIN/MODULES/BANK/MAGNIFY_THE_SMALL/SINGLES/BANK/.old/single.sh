#!/bin/bash
exec 2>/tmp/err
plugin_name=$1
shift
args=( $@ )

trap_err(){
    local str0="${BASH_SOURCE[1]}"
    local str="gvim +${str0}"
    local cmd=$( gxmessage -file /tmp/err -title 'trap_err' -entrytext "$str" )
    eval "$cmd"
    go_home
}
steps(){
    trap trap_err ERR
    proxy "print_color_n 32 '[SINGLE]'"
    dir_self=`dirname $0`
    script="$dir_self/$plugin_name/$plugin_name.sh"
    if [ -f "$script" ];the
        cmd="$runner_debug $script ${args[@]}"
        #echo "$cmd"
        present pv "$cmd"
        eval "$cmd"
    else
        echo no such script "$script"
    fi
}
steps
