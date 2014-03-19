#!/bin/bash 
#set -o nounset
pushd `dirname $0`
#echo "$@" >> $log_wrapper.txt
################################## start
path=`dirname $0`
num="${1:-1}"
notify-send "croning choose:" " $num"
sleep "$num"
#########################################
print_func(){
    echo 'print_func:'
    echo -e "\t\tfunc: ${FUNCNAME[1]}"
}
update_logger(){
print_func
echo "$@" >>  $dir_log/log.txt
}


exiting(){
echo exiting
exit 1
}
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
    file_err=$dir_log/err

    file_log_out=$dir_log/out
    file_list=$path/list.txt
}
   
set_env(){
    /usr/bin/env -i $( cat $file_env ) >/dev/null
echo
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
    echo 'set  timing'
date1=`date | tr -s ' ' | cut -d' ' -f4 | sed 's/:/_/g'`
notify-send "set timing" "$date1"
time=`echo "$date1" | cut -d':' -f3`
time_minute=`echo $time | cut -d'_' -f2 `
notify-send "set timing" "$time_minute"
echo "time minute: $time_minute"
#cmd="num=$time_minute/5"
#let "num=$time_minute/5"
#echo "$cmd"
#eval "$cmd"
#echo "num is: $num "

}
pick_task(){
#    http://www.cyberciti.biz/faq/bash-for-loop/
   echo 'pick task' 

#echo "minutes: $time_minute"
max=`cat $file_list | wc -l`
let "max=$max"
notify-send "croning bank:" "$max"
echo  "number of tasks:"
let "i=$max"
while [ $i -gt 0 ];do

cmd="let \"num=$time_minute%$i\""
#echo "$cmd"
eval  "$cmd"
#       echo
#       echo "num is: $num"
        if [ $num -eq 0  ];then
let            "choose=$max-$i"
            echo "task index chosen:" "$choose"

            break
        else
               echo -n "."

        fi

        let 'i-=1'
    done
}

run(){
    print_func
    #task_index=$(set_timing)
    set_timing
    pick_task
    eval "$path/croning.sh $choose" 

#    print_file $file_out
#    print_file $file_err
}
wrap_runner(){
    [ -f $file_err  ] && rm $file_err
cmd=run

    eval "$cmd" 2>$file_err 
    #1>$file_out
    cat $file_err
    str_time=`ls -l $dir_log/err |  tr -s ' ' | cut -d' ' -f8`
    echo $str_time
    cmd="gxmessage -file $file_err -title \"croning error: $str_time\""
    echo "$cmd"
    [ -s $file_err  ] && eval "$cmd"
}

print_file(){
    file=$1
echo $file
echo '----'
cat $file
}
show_last_error(){

    file=$dir_log/err
    if [ -s "$file" ];then
    gxmessage -file "$file" -title 'cron has errors!'
    exiting
else
    echo '[status] file errors is empty'
fi
}
steps(){
    exports
show_last_error
    #set_user
update_logger
    set_env
    wrap_runner

}

steps

popd
