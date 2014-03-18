#!/bin/bash
pushd `dirname $0`

################################## start
path=`dirname $0`
num="${1:-1}"
notify-send "croning choose:" " $num"
sleep "$num"
#########################################
print_file(){
    file=$1
    echo
    echo $file
    echo '-----'
    cat $file
    echo
}
create_dir(){
    dir=$1
[ ! -d $dir ] && mkdir -p $dir
}
exports(){
    #create dirs
    dir_log=$path/log
    dir_env=$path/env
    create_dir "$dir_log"
    create_dir "$dir_env"
    #set file names to be used later
    file_env=$dir_env/env.cfg
    file_log_err=$dir_log/err
    file_log_out=$dir_log/out
}
   
set_env(){
    /usr/bin/env -i $( cat $file_env )
}
set_user(){
    if [ "$(id -u)" != "0" ]; then
        user='user'
    else
        user='root'
    fi
    notify-send "$user"
}         
set_timing(){
time=`date | tr -s ' ' | cut -d' ' -f4 | sed 's/:/_/g'`
notify-send "set timing" "$time"
time_minute=`echo "$time" | cut -d':' -f3`
notify-send "set timing" "$time_minute"
}


run(){
    task_index=$(set_timing)
    eval "$path/croning.sh $num" 

#    print_file $file_out
#    print_file $file_err
}
wrap_runner(){
    [ -f $file_err  ] && rm $file_err
cmd=run
    eval "$cmd" 2>$file_err 1>$file_out
    cat $file_err
    cmd="gxmessage -file $file_err -title 'wrap croning'"
    [ -s $file_err  ] && eval "$cmd"
}


steps(){
    set_user
    exports
    set_env
    wrap_runner
}
steps

popd
