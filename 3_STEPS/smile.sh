#!/bin/bash
pushd `dirname $0`> /dev/null
dir=`pwd`
clear


edit(){
eval $EDITOR_GUI $file
}


run(){
echo

echo "INCREASE YOUR EFFICIENCY!"
echo "how?"
echo "wait.. 5 seconds and breath"
sleep 5
dir=`pwd`
file=$dir/priorities.yml
#dir_link=$dir/links
#$dir_link/wrapper.sh
cat $file
echo
echo
echo 'press control+c : for updating your priorities'
echo
echo 'sleep 10 seconds..'
trap edit SIGINT
sleep 10
}
run
popd
