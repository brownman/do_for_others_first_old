#!/bin/bash
#url: http://www.thegeekstuff.com/2009/09/unix-sed-tutorial-printing-file-lines-using-address-and-patterns/
file_yaml=list.yaml
subject=project
str_res=''

step1(){
# > /tmp/res 
local line=$( cat $file_yaml | grep $subject -A 1 | cut -d':' -f2| cut -d'-' -f2- | tr -s ' ' )
#| clear && cat  /tmp/res | tail -1 )
echo "res: $line"
}
step2(){
echo
}
step3(){
echo
}

steps(){
step1
step2
step3
}

steps
