#!/bin/bash
#info: 
pushd `basename $0`>/dev/null
file=$1
user=$LOGNAME
ls -l $file
sudo chown $user $file
sudo chgrp $user $file
ls -l $file | grep root --color=auto
popd>/dev/null
