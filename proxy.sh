#!/bin/bash
exec 2>/tmp/err

trap_err(){
    local str_caller=`caller`
    local cmd0="gvim +$str_caller"
    proxy notify-send 'proxies.breath' 'trap error'
    local cmd="gxmessage -file  /tmp/err -title 'proxies.breath: trap error ' -timeout 5 -entrytext='$cmd0'"
    ( echo proxy \"$cmd\" )
    local last="$( cat -n /tmp/proxy | tail -1 )"
    proxy present pv \"$last\"
    proxy cat /tmp/err
}
#export -f trap_err
trap trap_err ERR

exiting(){
    echo exiting 
    exit
}

if [ $# -gt 0 ];then
    subject="$1"
    notify-send "$0" "$subject"
    bash -c "$dir_root/PROXIES/breath.cfg $subject"
else
    notify-send  proxy 'supply a subject'
fi

