pending_cron_is_running(){
    local str=$(     sudo service cron status) 
    local result=$( grep 'cron is running.' $str )
    assertEqual "$result" "" 
}
info(){
    /usr/bin/env -i $(cat /tmp/cron-env)
}
update_env(){
    #source /etc/profile
    source /home/$USER/.bashrc
}
action(){
    local file=/home/$USER/magnify_the_small/genius.sh
    local cmd="$file one_cron \"$str1\""
    local result=$( eval "$cmd" )
    echo "$result"
}


load_cron_env(){
    file_env=$dir_cfg/env_dump.cfg
    source $file_env
}
file_tmp=/tmp/crontab.txt
file=$dir_script/reminder.txt
cmd=${1:-'run'}

minutes_reminder=1
minutes_todo=2
minutes_suspend=5

generate(){
    local file=$1
    echo -e "DISPLAY=:0
    */$minutes_reminder * * * * bash -c $dir_script/reminder.sh
    */$minutes_todo * * * * bash -c  $dir_script/todo.sh
    */$minutes_suspend * * * * bash -c  $dir_script/suspend.sh" > $file
}


install(){
    if [ ! -f $file_tmp ];then
        echo "creating file $file"
        touch $file_tmp
    fi
    generate $file_tmp

    clear
    cat $file_tmp
    echo update cron job ?

    read answer
    if [ "$answer" = y ];then
        crontab $file_tmp
        sudo service cron restart
    else
        echo skip updating cron
    fi
}



