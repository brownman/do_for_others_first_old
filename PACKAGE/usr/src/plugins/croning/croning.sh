#!/bin/bash
dir=`pwd`
user=''

if [ "$(id -u)" != "0" ]; then
    user='user'
else
    user='root'
fi

run(){

time1=`date | cut -d' ' -f4 | sed 's/:/_/g'`
file=/home/dao04/Desktop/${time1}_${user}.txt
touch $file
crontab -l > $file

flite -t "$user"
notify-send "$user"
xcowsay "$user"

}
install(){
    if [ "$user" = root ];then
        file=$dir/txt/crontab.user.txt
        sudo crontab $file
        echo "RESULTS:"
        sudo crontab -l
    else
        file=$dir/txt/crontab.user.txt
        crontab $file
        echo "RESULTS"
        sudo crontab -l
    fi
}
cmd=${1:-run}
eval "$cmd"
