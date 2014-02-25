#!/bin/bash -e
#http://askubuntu.com/questions/107726/how-to-create-animated-gif-images-of-a-screencast

trap breaking SIGINT
time1=`date | cut -d' ' -f4 | sed 's/:/_/g'`
title=${1:-$time1}
dir=/tmp/animated
if [ ! -d "$dir" ];then
mkdir $dir
fi

file_output="/tmp/animated/${title}.gif"
browser=google-chrome
resx=1280
resy=800
seconds=60

cmd_record="byzanz-record --duration=$seconds --x=0 --y=0 --width=$resx  --height=$resy $file_output"
cmd_browser="$browser $file_output"

breaking(){
echo Breaking..

echo "file_output: $file_output"
echo "google-chrome $file_output"

}

run(){
echo "$cmd_record"
eval "$cmd_record"
}




run

eval "$cmd_browser" &

