#!/bin/bash 
set -x
set -o nounset

path=`dirname $0`
pushd "$path">/dev/null
#echo "$@" >> $log_wrapper.txt
################################## start

#num="${1:-1}"
#notify-send "croning choose:" " $num"
#sleep "$num"
#########################################
print_caller(){
    print_func
local num=$1
    echo -e "\t\t[ caller ] [ $num ]: ${FUNCNAME[${num}]}"
}
cat(){
    print_func
print_caller 1    
print_caller 2    
file=$1
/bin/cat $file
}
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
    print_func
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
print_func
    #create dirs
    dir_log=$path/log
    dir_env=$path/env
#######################installation#####################
    create_dir "$dir_log"
    create_dir "$dir_env"
    ##################################
    #set file names to be used later
    file_env=$dir_env/env.cfg
    file_err=$dir_log/err

    file_log_out=$dir_log/out
    file_list=$path/list.txt
    source $path/setup.cfg
}
   
set_env(){
    print_func
    if [ -f "$file_env" ];then
    /usr/bin/env -i $( cat $file_env )
else
    reason_of_death 'env file not found - use crontab to create one' "$file_env"
fi
}
set_user(){
    print_func
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
xcowsay "$time_minute"
echo "time minute: $time_minute"
}
pick_task(){
#    http://www.cyberciti.biz/faq/bash-for-loop/
   print_func
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
reset_log(){
    [ -f $file_err  ] && rm $file_err
}
wrap_runner(){
    print_func
cmd=run

    eval "$cmd" 2>$file_err 
    #1>$file_out

    str_time=`ls -l $dir_log/err |  tr -s ' ' | cut -d' ' -f8`
    echo $str_time
#    cmd="gxmessage -file $file_err -title \"croning error: $str_time\""
    echo "$cmd"

    [ -s $file_err ] && cat $file_err
 #   [ -s $file_err  ] && eval "$cmd"
}

print_file(){
    print_func
    file=$1
echo $file
echo '----'
cat $file
}
show_last_error(){

print_func
    file=$dir_log/err
    if [ -s "$file" ];then
    gxmessage -file "$file" -title 'cron has errors!'
    exiting
else
    echo '[status] file errors is empty'
fi
}
steps(){
print_func

################am I root?
set_user

################set global vars / list.txt can use it
exports

################ load cron's env dump
set_env

################ show error generated by the cron service
show_last_error

################ save the cli call
update_logger

################ 
reset_log
wrap_runner

}

steps

popd
