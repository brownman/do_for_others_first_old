#!/bin/bash -e
#info: execute a script and print its errors
echo  proxy print_script
set -o nounset
################################## start
export file_error=/tmp/err
export file_out=/tmp/out
args=()
#path_self=`dirname $0`
if [ "$#" -gt 0  ];then
    args=( "$@" )
else
echo  proxy reason_of_death 'supply arguments'
fi
#########################################

parse_error_line(){
    proxy  print_func_n
    local   line="$1"
    if [ -n "$line" ];then
        proxy   proxy trace "[LINE] $line"
        local arr=()
        proxy  str_to_arr "$line" ':'
        local   max="${#arr[@]}"
        echo "maxX: $max"
        echo "arr: ${arr[@]}"
        if [ "$max" -gt 1 ];then
            proxy trace            echo '[DETAILS]' 
            proxy trace       echo "file:" "${arr[0]}"
            proxy trace  echo "line:" "${arr[1]}"
            proxy trace    echo "msg:" "${arr[2]}"
            proxy trace   echo
            str_line=$(echo "${arr[1]}" | sed 's/line//g'| sed 's/ //g')
            str_file="${arr[0]}"
            str_command="${arr[2]}"
            str_msg="${arr[3]}"
            cmd="vi $str_file +$str_line"
            proxy echo "$cmd"
            msg=`echo "$str_command" "$str_msg" | sed 's/ /_/g'`
            # notify-send "parse_msg:" "$msg"
            proxy            update_clipboard "$cmd"

        else
echo            proxy  reason_of_death 'incorrect parsing of line' "$file"
        fi
    else
    echo    proxy  reason_of_death 'got empty line from file' "$file"
    fi
}

set_env(){
    /usr/bin/env -i $(cat $path_self/.usr.env)
}
set_user(){
    if [ "$(id -u)" != "0" ]; then
        user='user'
    else
        user='root'
    fi
    notify-send "$user"
}         
run(){
    #    pushd "$PWD">/dev/null
    echo

    #   popd>/dev/null
}
wrap_runner(){
    #info:   run a command in a sub-shell +  notify about errors
    #depend: $file_error $file_out ${args[@]}
    if [ ${#args[@]} -gt 0 ];then
        local cmd="${args[@]}"
        local cmd1=''
        [ -f "$file_error"  ] && rm $file_error
        [ -f "$file_out"  ] && rm $file_out
        ##################################    run##########
      proxy  echo -ne "[COMMAND] " 
      proxy   echo "$cmd"
        (  eval "bash -e $cmd" 2>$file_error 1>$file_out )
        ######################################################3
        if [ -s "$file_error"  ];then
            #cmd1="gxmessage -file $file_error -title 'wrap errors'"
            #eval "$cmd1"
          proxy  present_file $file_error
            local line=`cat $file_error`
         proxy   parse_error_line "$line"

        fi
        if [ -s "$file_out"  ];then
            cmd1="cat $file_out"
          proxy  "$cmd1"
        fi
    else
echo proxy reason_of_death 'no arguments'
    fi
}

set_dir_for_logs(){
    dir_log=$path_self/log
    if [ -d "$dir_log" ];then
     proxy   tree -L 2 $dir_log
        #echo
    else
    echo    proxy reason_of_death 'invalid directory' "$dir_log"
    fi



}


steps(){
    #    set_user
    #    set_env
    #    set_dir_for_logs
    wrap_runner
}
steps
set +o nounset
