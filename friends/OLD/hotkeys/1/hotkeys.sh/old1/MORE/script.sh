#!/bin/bash -e
args="$@"
cmd=${1:-run}
run(){
echo xbindkeys "$args"
}
step1(){
xbindkeys-config
}
step2(){
xbindkeys -k
}

test_something(){
echo hiii
}
simplest(){
xfce4-settings-editor
}
trick(){
mkdir /tmp/1/1
}
#someerrorrr
trick
#$cmd
