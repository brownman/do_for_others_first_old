#!/bin/bash 
# about file:
# plugin:        suspend
# description:   suspend the computer + limit powering-on to X seconds
# unlock: https://bugs.launchpad.net/ubuntu/+source/dbus/+bug/811441
# progress bar: http://bash.cyberciti.biz/guide/A_progress_bar_(gauge_box)
#. $TIMERTXT_CFG_FILE
trace print_got "suspend.sh got: $@"

timeout=${TIMEOUT_SUSPEND:-60}
alive=${TIMEOUT_ALIVE:-60}
trace "timeout suspend set to : $timeout"
#$TIMEOUT_LET_ME_SLEEP
#env > $dir_workspace/log/suspend.env.log
trace(){
    local args=( "$@" ) 
    local cmd="${args[@]}"
    


echo "$cmd" >> /tmp/trace

echo "$cmd"
}

suspend01(){

trace start | flite
    trace "suspend01().."
    local elapsed=0
    local before=`date +%s`

    trace -n "let me sleep timeout -  is:"
    trace "$timeout"


    sleep 5
xcowsay 'suspend!'

    sleep 1
    res=$( dbus-send --system --print-reply     --dest="org.freedesktop.UPower"     /org/freedesktop/UPower     org.freedesktop.UPower.Suspend 2>/dev/null )
    trace "res:  $res"
    local after=`date +%s`
    let elapsed=after-before
    trace -n "slept for: "
    trace "$elapsed"
    if [[ $elapsed -lt $timeout ]];then
        trace "let me sleep for at least $timeout seconds"
        flite -t 'let me sleep'
        sleep 5
        eval suspend01
    else
        trace 'you are free now - act wisely'
    fi
    #$tasks_sh commitment notebook
    #$tasks_sh commitment task 

    
}



eval suspend01

