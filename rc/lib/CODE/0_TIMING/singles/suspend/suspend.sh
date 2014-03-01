#!/bin/bash 
# about file:
# plugin:        suspend
# description:   suspend the computer + limit powering-on to X seconds
# unlock: https://bugs.launchpad.net/ubuntu/+source/dbus/+bug/811441
# progress bar: http://bash.cyberciti.biz/guide/A_progress_bar_(gauge_box)
#. $TIMERTXT_CFG_FILE
echo print_got "suspend.sh got: $@"
timeout=${TIMEOUT_SUSPEND:-60}
#$TIMEOUT_LET_ME_SLEEP
env > ~/Desktop/suspend.env.log


suspend01(){

echo start | flite
    echo "suspend01().."
    local elapsed=0
    local before=`date +%s`

    echo -n "let me sleep timeout -  is:"
    echo "$timeout"


    sleep 5
xcowsay 'suspend!'

    sleep 1
    res=$( dbus-send --system --print-reply     --dest="org.freedesktop.UPower"     /org/freedesktop/UPower     org.freedesktop.UPower.Suspend 2>/dev/null )
    echo "res:  $res"
    local after=`date +%s`
    let elapsed=after-before
    echo -n "slept for: "
    echo "$elapsed"
    if [[ $elapsed -lt $timeout ]];then
        echo "let me sleep for at least $timeout seconds"
        sleep 5
        eval suspend01
    else
        echo 'you are free now - act wisely'
    fi
    #$tasks_sh commitment notebook
    #$tasks_sh commitment task 

    
}



eval suspend01

