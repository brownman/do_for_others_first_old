#!/bin/bash
$dir=`dirname $0`
file=$dir/priorities.yml

print_color 35 "update Todo.txt"
echo "How ?"

edit(){
eval $EDITOR_GUI $file
}
run1(){
print_color 36 "YOU CAN DO BETTER:"
#dir_link=$dir/links
#$dir_link/wrapper.sh
cat $file
echo
echo
print_color 31 'press control+c : for updating your priorities'
echo
echo "sleep $delay seconds.."
trap edit SIGINT
sleep $delay
}
run1




