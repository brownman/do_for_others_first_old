#!/bin/bash 
pushd `dirname $0`>/dev/null
source .helper.cfg
str=`source .flow.cfg`
echo "$str"
#parse_error_line "$str"
popd>/dev/null
