


#!/bin/bash
#http://subsignal.org/doc/AliensBashTutorial.html#4_e
#http://c.learncodethehardway.org/
pushd `dirname $0` > /dev/null
renice 10 -p $$
#flite 'genius'
#chmod +w time
#ls -d -l time
str="$@"
#notify-send "genius:" "$str"
export ROOT_DIR=$PWD
export file_loader=$ROOT_DIR/script/loader.sh
. $file_loader



input="$1"
if [ $# -gt 1 ];then
    shift
    args=( "$@" )
fi


trace "pid: $$"
dir1=$SCRIPT_DIR/time
result='equal'

#clean_file "$file_logger"
show_env(){
    red show_env
    green "MUTE_CHILD: $MUTE_CHILD"
    sleep1 5
}
run(){


    show_env
    if [ "$input" = '' ];then

        trace 'no arguments to genius'
        notify_send1 'SED' 'examples' 



        cmd="sed -n -e '/{$/p' | cut -d'(' -f1"
        #cmd=$( gxmessage $GXMESSAGET -entrytext "$cmd" -title 'update cmd' "input" )

        cmd="cat $SCRIPT_DIR/tasks/tasker.sh | $cmd"
        funcs=$(commander0 "$cmd")

        echo "$funcs" > /tmp/funcs.txt
        local result=$(zenity1 /tmp/funcs.txt)


    else
        file11=$dir1/$input.sh
        if [ "$CATCH_ERROR" = true ];then
            result=$( $file11 "${args[@]}"  2> $file_error )
        else
            result=$( $file11 "${args[@]}"  )
        fi


    fi

#    cmd="tasker $result"
#    detach "$cmd"
}
run

popd > /dev/null


