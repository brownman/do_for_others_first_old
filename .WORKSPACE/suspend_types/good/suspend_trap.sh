#!/bin/bash 
#goo boo
# about file:
# plugin:        suspend
# description:   suspend the computer + limit powering-on to X seconds
# unlock: https://bugs.launchpad.net/ubuntu/+source/dbus/+bug/811441
# progress bar: http://bash.cyberciti.biz/guide/A_progress_bar_(gauge_box)
#. $TIMERTXT_CFG_FILE
proxy(){
    local args=( $@ )
    local cmd="${args[@]}"
    echo "$cmd" >> /tmp/root.proxy
    eval "$cmd"
}
trap_err(){
gxmessage  -file /tmp/err -title error -timeout 8

gxmessage  -file /tmp/proxy.root -title root.proxy -timeout 8
}
exec 2>/tmp/err
proxy trap trap_err ERR
#echo print_got "suspend.sh got: $@"

timeout=${TIMEOUT_SUSPEND:-60}
alive=${TIMEOUT_ALIVE:-60}
echo "timeout suspend set to : $timeout"
#$TIMEOUT_LET_ME_SLEEP
#env > $dir_workspace/log/suspend.env.log


suspend01(){

proxy "flite -t start"
    echo "suspend01().."
    local elapsed=0
    local before=`date +%s`

    echo -n "let me sleep timeout -  is:"
    echo "$timeout"


    sleep 5
proxy "xcowsay 'suspend!'"

    sleep 1

local     cmd="dbus-send --system --print-reply     --dest=\"org.freedesktop.UPower\"     /org/freedesktop/UPower     org.freedesktop.UPower.Suspend 2>/dev/null"
proxy "$cmd"
    local res=$?
    echo "res:  $res"
    local after=`date +%s`
    let elapsed=after-before
    echo -n "slept for: "
    echo "$elapsed"
    if [[ $elapsed -lt $timeout ]];then
        echo "let me sleep for at least $timeout seconds"
        proxy "flite -t 'let me sleep'"
        sleep 5
        proxy suspend01
    else
        echo 'you are free now - act wisely'
    fi
    #$tasks_sh commitment notebook
    #$tasks_sh commitment task 

    
}


[  -f /tmp/proxy.root ] && rm /tmp/proxy.root
proxy suspend01

