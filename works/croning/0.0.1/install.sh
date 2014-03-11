#!/bin/bash
#info: create symlink at: /tmp/CRONING 
#
#
dir_croning=`pwd`
export(){
#dir_croning=/tmp/CRONING
dir_indicator=$dir_croning/INDICATORS
dir_usr=$dir_indicator/usr
dir_admin=$dir_indicator/admin
script=$PWD/croning.sh
}
create(){
mkdir $dir_croning
mkdir $dir_indicator
mkdir $dir_usr
mkdir $dir_admin
}
link(){
ln -s $dir_croning /tmp/CRONING
}

steps(){
export
create
link
}
steps

