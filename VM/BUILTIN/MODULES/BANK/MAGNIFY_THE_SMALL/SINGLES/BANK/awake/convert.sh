#!/bin/bash
#depend: xsel 
#info: 
set_env(){
dir_self=`pwd`
file_target=$dir_self/awake.sh
file_sudoers=/etc/sudoers
}


permission(){
    file=$file_target
    user=root
    #$LOGNAME
    ls -l $file
    ls -l $file | grep root --color=auto
    sudo chown $user $file
    sudo chgrp $user $file
}

sudoers(){
    sudo cat $file_sudoers | grep $file_target --color=auto
    echo "echo \"ALL    ALL = (root) NOPASSWD: $file_target\"" | xsel --clipboard
    echo "[clipboard] updated !"
    echo "[next] update file: $file_sudoers"
}
present(){
type set_env
type permission 
type sudoers
}
steps(){
    preset
set_env
permission
sudoers
}
steps
