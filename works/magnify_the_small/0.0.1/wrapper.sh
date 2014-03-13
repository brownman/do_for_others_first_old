#!/bin/bash -e
#example: ./wrapper bin/0_sos/sos.sh
#set -o nounset
str='magnify the small'
flite "$str"
notify-send "$str"
xcowsay "$str"
clear
########################### RULES ********
# - use a wallpaper task to print the logs as output-of-the-day - on the desktop wallpaper!
# - handeling of errors - must be set here - because the loop must always running - because it is the best indicator for the user's efforts and effectivity !
#
# - project is a sub-project and it is independant of external changes!
# - reason: sos.sh must run no-metter what!
###########################################
pushd `dirname $0`
export dir_root=`pwd`
############################################
source setup.cfg
notify-send "sound: $SOUND"
# - export structure:           where is the workspace ?
# - export vars:                run with sound?
# - create folders/symlinks:    desktop lymlink exist ?
############################################



run(){
    if [ "$task" ];then
        cmd="$task" 
        echo "$cmd"
        eval "$cmd"
    else
        echo "supply a task"
        cat $0 | grep example -m1
    fi

}
steps(){

#    install_trap
print_func
print_func_content "$0" "steps"

print_layout


[ -n "$task" ] && generate_indicator "$task"
[ -n "$task" ] && run
}


task=${1:-''}
steps

popd
