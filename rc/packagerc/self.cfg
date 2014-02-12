#!/bin/bash
#filename:     self.cfg
#version:   0.0.1
#date:      12.2.2014
#depend:    gxmessage gmail-notify libnotify-bin
#help:      utilize shared gmail to act like the mobile application: whatsup 
#arguments: update your .bashrc with USER=gmail_nickname PASSWORD=gmail_passwort
#check:     ps -ef | grep gmail-notify | grep -v grep


print_func(){
    local str=${FUNCNAME[1]}
    #      echo "function name is  - $str" | flite
    echo "FUNC: $str" 
}


show_self(){
    local script=$0
    color1 ":"
    color2 ":"
    color3 ":"
    color4 ":"
    functions=`grep -h '()' $0 | cut -d '(' -f 1`
    #functions=`grep -h test_ $0 | cut -d '(' -f 1`
    for i in $functions; do
        # rm -rf $dir_base/tmp/*
        # $i
        echo "  $i"
    done
    #edit_self
}

help(){
    cat $0 | grep 'help:'
}

install(){
    result=$( cat $0 | grep 'depend:' )
    echo 'Please install dependencies by issue the command:'
    echo  "sudo apt-get install $result"
}

check(){
    cat $0 | grep 'check:'
}

