#!/bin/bash
/usr/bin/flite -t 'croning'
    /usr/games/xcowsay 'croning is alive'

if [ $# -gt 0 ];then

    /usr/bin/flite "$1"
    /usr/bin/notify-send "$1"
else
    /usr/bin/notify-send 'no args'
fi



