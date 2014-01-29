


#!/bin/bash
#http://subsignal.org/doc/AliensBashTutorial.html#4_e
#http://c.learncodethehardway.org/
pushd `dirname $0`
#> /dev/null
#renice 10 -p $$
#flite 'genius'
#chmod +w time
#ls -d -l time
str="$@"
#notify-send "genius:" "$str"
export ROOT_DIR=$PWD
export file_loader=$ROOT_DIR/script/loader.sh
. $file_loader



input="$1"
if [ $# -gt 0 ];then
    args=( "$@" )
fi


run(){


    #show_env
    cmd="$PROJECT_DIR/genius.sh single ${args}"
    #detach "$cmd"
    eval "$cmd"
}
run

popd > /dev/null


