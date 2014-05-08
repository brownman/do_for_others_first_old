#!/bin/bash -e



args="$@"
path=`dirname $0`
echo "restart $args" | flite &
notify-send "restart $args" 



source $path/cfg/struct.cfg

load_cron_env(){
file_env=$dir_cfg/env_dump.cfg
source $file_env
}
run(){
load_cron_env
cmd="$dir_project/run.sh $args"
eval "$cmd" 2>$dir_txt/error.txt
}
run

