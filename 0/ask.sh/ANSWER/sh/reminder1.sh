#!/bin/bash
#change between false and true - to mute / unmute

mute=false
create_desktop_shortcut=true
#path=`dirname $0`
plugin_name=reminder
file=$dir_workspace/$plugin_name.txt

#file_shortcut=~/Desktop/REMINDERS_$time.txt
file_shortcut=~/Desktop/REMINDERS.txt
if [ ! -f $file ];then
    touch $file
fi
if [ ! -s $file ];then
    reason_of_death  $file empty
fi

if [ "$UPDATE_DESKTOP" = true ];then

    if [ ! -h $file_shortcut ];then
        ln -s $file $file_shortcut
        print_note 'generating desktop Shortcut for reminder.txt'
        echo "$file_shortcut"
        ls -l "$file_shortcut"
    else
        echo 'symlink already exist'
    fi
#    if [ ! -L $file_shortcut ];then
#        ln -s $file $file_shortcut
#    else
#        echo 'symlink already exist'
#    fi
else
    echo  'skip: updating the desktop:with symlinks'
fi

cmd=${1:-'run'}

run(){
    local line=$(random_line $file)
    speak "$my_name" false
    sleep1 2
    speak "$line"

}

random_line(){
    local file=$1
    local line=$(shuf -n 1 $file)
    echo "$line"
}
run
