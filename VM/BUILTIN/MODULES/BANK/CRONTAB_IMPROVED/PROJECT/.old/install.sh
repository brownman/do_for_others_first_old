#!/bin/bash
#info: create symlink at: /tmp/CRONING 
#
#

export(){
dir_croning=`pwd`
dir_indication=$dir_croning/INDICATION
dir_env=$dir_croning/env
dir_log=$dir_croning/log
script=$dir_croning/wrapper.sh
dir_target=/tmp/CRONING
}

create(){
#[ ! -d  "$dir_target"  ] && mkdir $dir_target
echo
}

link(){
ln -sf $PWD  /tmp/CRONING

#$dir_indication /tmp/CRONING/INDICATION
#ln -s $dir_env /tmp/CRONING/env
#ln -s $dir_log /tmp/CRONING/log
#ln -s $script /tmp/CRONING/wrapper.sh
}

steps(){
export
create
link
}
steps

