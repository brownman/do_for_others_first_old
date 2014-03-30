#!/bin/bash -e 


path=`pwd`
#path=`dirname $0`
export dir_base=$path
source $dir_base/cfg/struct.cfg
#source $dir_base/cfg/error.cfg

source $dir_base/cfg/colors.cfg
source $dir_base/cfg/vars.cfg

if [ "$1" ];then
    script="$1"
    if [ "$2"  ];then

    shift
        args=( "$@" )
        cmd="$dir_bin/$script.sh ${args[@]}"
    else
        cmd="$dir_bin/$script.sh"
    fi
    echo "cmd: $cmd"
   # echo press Enter
   # read
    eval "$cmd"
else
    clear

    #print_status $dir_bin
    print_status Options are:

  #  echo press Enter
  #  read
    ls -1 $dir_bin | sed 's/.sh//g'
    print_good "Tip - try to run:"
    echo "./smaller.sh test"
fi

