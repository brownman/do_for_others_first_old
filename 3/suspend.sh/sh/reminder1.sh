#!/bin/bash -e

#change between false and true - to mute / unmute
mute=false
plugin_name=reminder
dir=$dir_constants/txt
file=$dir/$plugin_name.txt
file_shortcut=~/Desktop/REMINDERS.txt

if [ ! -h $file_shortcut ];then
ln -s $file $file_shortcut
else
    echo 'symlink already exist'
fi
if [ ! -L $file_shortcut ];then
ln -s $file $file_shortcut
else
    echo 'symlink already exist'
fi



if [ ! -d $dir ];then
    mkdir $dir
fi
if [ ! -f $file ];then
    touch $file
fi
if [ ! -s $file ];then
    reason_of_death  $file empty
    exiting
fi

cmd=${1:-'run'}

run(){
    local line=$(random_line $file)
    speak "$my_name"
    sleep1 2
    speak "$line"

}
speak(){
    local    line="$1"
    notify-send "$line" & 
    if [ "$mute" = false ];then

        echo "$line" | flite -voice slt &
        sleep 1
        echo "$line" | flite -voice kal &
        sleep 1
        echo "$line" | flite -voice awb &
    fi
}


random_line(){
    local file=$1
    local line=$(shuf -n 1 $file)
    echo "$line"
}
run
