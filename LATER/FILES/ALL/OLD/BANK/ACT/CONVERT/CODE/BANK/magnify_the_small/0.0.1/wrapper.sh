#!/bin/bash   -e
export TRAP_ERROR=false
#example: ./wrapper bin/0_sos/sos.sh
set -o nounset
pushd `dirname $0`
export dir_root=`pwd`
############################################

#cmd="source setup.cfg 1>/dev/null"

#proxy "$cmd"
source $dir_root/setup.cfg
#echo -n '' > $file_logger
#proxy update_logger "$0" "$@"

################################### dirty
#echo "$@" | xsel --clipboard
#echo "$@" >> log_wrapper.txt

#notify-send "wrapper got" "$@"
proxy notify-send "sound: $SOUND"
# - export structure:           where is the workspace ?
# - export vars:                run with sound?
# - create folders/symlinks:    desktop lymlink exist ?
############################################



run(){
    if [ "$script" ];then
        if [ "${#args[@]}" -gt 0 ];then
            cmd="$script ${args[@]}" 
        else
            cmd="$script"
        fi



        echo "$cmd"
        eval "$cmd"
    else
        echo "supply a script"
        cat $0 | grep example -m1
    fi

}
steps(){
proxy    print_func
    res_str=$( echo "$script" | grep 'bin/' )
    res_num=$?
#    [ $res_num -eq 0 ] && generate_indicator "$script"
    [ -n "$script" ] && [ -f "$dir_root/$script" ] && run 
}

args=()
script=${1:-''} 
if [ $# -gt 1 ];then
    shift
    args=( "$@" )
fi




#[ -f "$dir_root/$script" ] && steps
proxy steps

popd
#. ./sctrace.sh
set +o nounset
cat /tmp/proxy
