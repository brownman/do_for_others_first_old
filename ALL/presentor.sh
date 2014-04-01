#!/bin/bash
#info: present the yaml
#moto: not presented = not exist
dir_self=`dirname $BASH_SOURCE`
source $dir_self/breath.cfg
start(){
local    str="presenting.."
    proxy "toilet --gay \"$str\""
}




steps(){
    start
}



. $file_standard
#ensure_standards

