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
dir="/home/$NAME/Desktop/croning"
if [ ! -d "$dir" ];then
    mkdir "$dir"
fi
file=$dir/${time1}_${user}.txt
touch $file
crontab -l > $file

flite -t "$user"
notify-send "$user"
util=/usr/games/xcowsay
$util "$user"

}
install(){
    if [ "$user" = root ];then
        file=$dir/txt/crontab.root.txt
        sudo crontab $file
        echo
        echo
        echo -e "\t\t\t\tRESULTS:"
        sudo crontab -l
    else
        file=$dir/txt/crontab.user.txt
        crontab $file
        echo 
        echo
        echo -e "\t\t\t\tRESULTS:"
        sudo crontab -l
    fi
}
cmd=${1:-run}
eval "$cmd"
