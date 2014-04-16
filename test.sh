#!/bin/bash

set -o nounset
export dir_root=`dirname $0`
source $dir_root/.0_effort.cfg

step1(){
$dir_root/LAB/breath.cfg
}

step2(){
   wget -qO - http://www.asciiartfarts.com/random.cgi | sed -n '/<pre>/,/<\/pre>/p' | sed -n '/<table*/,/<\/table>/p' | sed '1d' | sed '$d' | recode html..ascii;
}


steps(){
step1
step2
}

steps
