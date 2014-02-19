#!/bin/bash
pushd `dirname $0`> /dev/null
dir=`pwd`


edit(){
eval $EDITOR_GUI $file
}


run(){
echo


print_color 35 "update Todo.txt"
echo "How ?"
sleep 2
echo "Wait.. 5 seconds and breath"
sleep 5
dir=`pwd`
file=$dir/priorities.yml

print_color 36 "YOU CAN DO BETTER:"
#dir_link=$dir/links
#$dir_link/wrapper.sh
cat $file
echo
echo
print_color 31 'press control+c : for updating your priorities'
echo
echo 'sleep 10 seconds..'
trap edit SIGINT
sleep 10
}
run
popd
