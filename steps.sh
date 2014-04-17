#source ~/bashrc_additions.cfg

#type proxy
#alias proxyE
#echo running
#sleep 3
#bash -c $dir_root/SOURCE/breath.cfg


#echo
#echo imagine first
#sleep 1
#echo bash -c $dir_root/.1_imagine_first.cfg
#echo bash -c "$dir_root/steps.cfg"
alias unset="set +o nounset"
cpu(){
    local args=( $@ )
    local cmd1="${args[@]}"
    eval "$cmd1" &
    cpu="renice 11 -p $!"
    eval "$cpu"
}
export -f cpu
#( notify-send 'proxy' 'print_tail at /dev/tty1';  watch tail /tmp/proxy >/dev/tty1 )

setup_hotkeys(){
    #reason: setup the hotkeys for the robot
     xfconf-query -c xfce4-keyboard-shortcuts -p "/commands/custom/<Alt>F1" -t string -s "gedit $dir_root/plan.txt" --create

xfconf-query -c xfce4-keyboard-shortcuts -p "/commands/custom/<Alt>F2" -t string -s "/home/dao04/JAIL/TREE/ENTER/BANK/proxy.sh hotkey" --create
}

advice_tty_watch(){
alias quick_tty1="tail -F /tmp/proxy >/dev/tty1"
echo quick_tty1
alias quick_tty1
alias quick_tty2="tail -F /tmp/err >/dev/tty2"
echo quick_tty2
alias quick_tty2

}
#every 5 "bash -c $dir_root/.1_genesis.sh"
#every 5 "bash -c $dir_root/.CHEAT/commands.sh grep"
file_present(){
local file=$1
local util=`which pv`
local cmd="cat $file | xargs -0 echo | $util -qL 10"
eval "$cmd"
}
load_project(){
#reason:show last errors/log
[ -s /tmp/proxy ] && { echo;echo /tmp/proxy;echo ---; cat -n /tmp/proxy | tail -1;echo; }
[ -s /tmp/err ] && { echo;echo -n /tmp/err;echo ---; cat /tmp/err;echo; }
tail -1 /tmp/err
#reason: enter the project is after knowing the targets: plan.txt /genesis.yaml
sleep 1
echo 1
sleep 1
echo 2
sleep 1 
echo 3
#reason: take it slowly now: 
alias cdcheat="cd $dir_root/.CHEAT"
alias cdtrick="cd $dir_root/.CHEAT"
alias cdworkspace="cd $dir_root/ACT/BANK/WORKSPACE"
alias cdmodel="cd $dir_root/SOURCE"
alias cdact="cd $dir_root/ACT"

source $dir_root/SOURCE/breath.cfg
every 5 advice_tty_watch
}
remind_mission(){
#reason: remind the target: mvc layout
echo m
echo v
echo c
sleep 2
#reason: bashrc: about self: what i offer:
echo bashrc funcs: cpu/setup_hotkeys/file_present/advice_tty_watch
echo bashrc alias: grep1/
}
present_motivation(){
#reason: presentation before loading the project? #answer: YES!!!!!!! it is a must - because sometimes i just sink into a fucken bug and forget about everything else - I must take a farther glimps first!

file_present "$dir_root/plan.txt"
file_present "$dir_root/genesis.yaml"
}
grepping(){
    local cmd=$1
    local tag=$2
local str=$(    cat $0 | grep $cmd -A 2 | grep "$tag" | sed "s/\#$tag//g" )
echo " [ $cmd ]"
if [ -n "$str" ];then
echo -n "[ reason ]"
pv "$str"
else
    print_color  31 "[ERROR] update function [ $cmd ] with tag:[ $tag ]"



cmd="cat $0 | grep -n \"$cmd\" -m1 | cut -d':' -f1"
echo "$cmd"
local lineno=$( eval "$cmd" )
cmd="vi +${lineno} $0"
echo update_clipboard "$cmd"

    exit
fi

}
stepping(){
    sleep 1
    clear
    echo -n "[stepping] "

local cmd=$1
grepping "$cmd" reason

echo $cmd
sleep 1
eval "$cmd"
sleep 2
}
steps(){
stepping setup_hotkeys
stepping remind_mission
stepping present_motivation
}
clear
echo "[ runner ]  $0"
sleep 3
if [ $0 = bash ];then
cmd="load_project"
eval "$cmd" 1>/dev/null
every 2 "$cmd"
else
cmd="$dir_root/SETUP/list.sh"
eval "$cmd"
fi
