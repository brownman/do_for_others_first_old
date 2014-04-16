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


#args=( $@ )
#cmd="${args[@]}"

#notify-send 'proxy'
exiting(){
echo exiting 
exit

}
proxy () 
{ 
    local str_caller=`caller`;
    local args=($@);
    local runner="${args[0]}";
    local cmd="${args[@]}";
    local max="${#args[@]}";
    local verbose=${VERBOSE:-false};
    type "$runner" > /dev/null 2> /dev/null || { 
    echo 
    msg="[ERROR] command not found: $runner";
    echo "$msg"
    echo "$msg" >> /tmp/proxy
exiting
#proxy go_home
};
if [ "$verbose" = true ]; then
    echo "PROXY ($max): $cmd";
fi;
echo "vi +$str_caller # $cmd" >> /tmp/proxy;
eval "$cmd"
                                                                            }

                                                                            if [ $# -gt 0 ];then


                                                                                subject="$1"

                                                                                notify-send proxy "$subject"
                                                                                bash -c "$dir_root/PROXIES/breath.cfg $subject"
                                                                            else
                                                                                notify-send  proxy 'supply a subject'
                                                                            fi

