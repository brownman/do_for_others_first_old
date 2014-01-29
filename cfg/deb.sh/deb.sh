#!/bin/bash -e

path=`dirname $0`
source $dir_cfg/args.cfg
set_script_and_args
echo "script: $script"
exit

source $dir_cfg/colors.cfg
source $dir_cfg/self.cfg
if [ "$path" ];then
$( eval $script ${args[@]} )
else
    
    show_options $path/bin 
fi

