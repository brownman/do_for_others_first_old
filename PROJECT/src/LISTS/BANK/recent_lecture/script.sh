#!/bin/bash

steps(){
str=`cat lecture.txt`
cmd="vlc $str"
echo "$cmd"
echo "$cmd" |xsel --clipboard
}

steps
