#!/bin/bash -e
#presentation: record when running

clear
set -o nounset

dir_this=`pwd`
pushd $dir_this 
dir_rc=$dir_this/ALL/RC
source  $dir_rc/library.cfg

use packagerc.color.colors


create_screencast(){
    echo "create screencast"
    local str=${1:-''}
    local str_ws=`echo "$str" | sed 's/ /_/g'`
    local signature=`date | cut -d' ' -f4 | sed 's/[: ]/_/g'`
    local title=${signature}__${str_ws}
    echo "title: $title" 
    $dir_this/STEPS/wrapper.sh "$title"
 
}

steps(){
    echo "steps()"

    echo "Presentation:"
    echo "Enter Title:"
    read answer
    create_screencast "$answer"

}


steps
popd

