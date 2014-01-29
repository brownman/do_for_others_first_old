#!/bin/bash
act=$1
shift
args="$@"

path=`dirname $0`
dir_sh=$path/act

run(){
$dir_sh/$act.sh "$args"

}
run
