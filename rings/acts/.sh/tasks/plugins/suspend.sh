#!/bin/bash
# about file:
# plugin:        suspend
# description:   suspend the computer + limit powering-on to X seconds
# unlock: https://bugs.launchpad.net/ubuntu/+source/dbus/+bug/811441
# progress bar: http://bash.cyberciti.biz/guide/A_progress_bar_(gauge_box)
#. $TIMERTXT_CFG_FILE
timeout=60
#$TIMEOUT_LET_ME_SLEEP

notify_send 'suspend!'
suspend01(){
    trace "suspend01().."
    local elapsed=0
    local before=`date +%s`

    echo -n "let me sleep timeout -  is:"
    trace "$timeout"
    sleep1 5
    res=$( dbus-send --system --print-reply     --dest="org.freedesktop.UPower"     /org/freedesktop/UPower     org.freedesktop.UPower.Suspend )
    trace "res:  $res"
    local after=`date +%s`
    let elapsed=after-before
    echo -n "slept for: "
    trace "$elapsed"
    if [[ $elapsed -lt $timeout ]];then
        echo "let me sleep for at least $timeout seconds"
        sleep1 5
        suspend01
    else
        trace 'you are free now - act wisely'
    fi
    #$tasks_sh commitment notebook
    #$tasks_sh commitment task 
}



suspend01

