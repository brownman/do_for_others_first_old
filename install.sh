#!/bin/bash -e
#name: life.sh
#date: 18.2.14
#package: do-for-others-first
set -o nounset


dir=`pwd`
dir_ready=$dir/READY
dir_src=$dir_ready/src
dir_rc=$dir_ready/rc
dir_3_steps=$dir_src/3_steps

source $dir_rc/bashrc.fun


steps(){
echo "Steps()"
$dir_3_steps/imagine_first/wrapper.sh
$dir_3_steps/croning/wrapper.sh
$dir_3_steps/hotkeys/wrapper.sh
}


steps

