#!/bin/bash

#http://www.cyberciti.biz/faq/linux-unix-formatting-dates-for-display/
dir_dropbox=~/Dropbox
dir_voices=$dir_dropbox/VOICES
if [ ! -d $dir_voices ];then
    echo "can't locate your dropbox folder"
fi


author=$LOGNAME
signature=`echo $(($(date +%s%N)/1000000))`

let 'remember=0'
dependencies(){
    sudo apt-get install gxmessage
}

show_dialog(){
    
local str=`gxmessage -file "$file" -title dropbox-voices-chat -timeout 10 -ontop -sticky -entry`
echo "$signature|$author|$author"
}

loop(){
    while true;then
        echo 'checking for new files...'
        #check the number of files in the directory
        result=`du $dir_dropbox | cut -d'/' -f1`
        if [ "$result" -gt "$remember" ];then
            show_dialog
        else
            echo 'they just the same.. :('
        fi
    done
}

run(){
#change the keyboar-layout for adding a keyboard-hotkey/keyboard-shortcut 
#i.g: alt+f2:/usr/bin/dropbox-voices.sh
show_dialog
}
run

