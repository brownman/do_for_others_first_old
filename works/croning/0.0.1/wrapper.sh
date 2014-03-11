#!/bin/bash

path=`dirname $0`

file_error=$path/.log/error
num="$1"
sleep "$num"
eval "$path/croning.sh $num" 2>$file_error

echo
[ ! -f $file_error  ] || cat $file_error


