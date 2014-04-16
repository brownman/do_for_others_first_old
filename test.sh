#!/bin/bash

set -o nounset
step1(){
dir_root=`dirname $0`
source $dir_root/.0_effort.cfg
$dir_root/LAB/breath.cfg
}
step3(){
env
}
step4(){
ls /usr/bin
}

step5(){
   wget -qO - http://www.asciiartfarts.com/random.cgi | sed -n '/<pre>/,/<\/pre>/p' | sed -n '/<table*/,/<\/table>/p' | sed '1d' | sed '$d' | recode html..ascii;
}


steps(){
#step1
step3
step4
step5
}

steps
