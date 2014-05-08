#!/bin/bash 
#depand var: file_list
set -o nounset
pushd `dirname $0` >/dev/null
source setup.cfg
str="croning is alive"
path=`dirname  $0`
popd>/dev/null
