#!/bin/bash -e
#http://www.unixmen.com/make-animated-gif-screencasts-easily-byzanz/
#http://pkgs.org/download/byzanz
#http://askubuntu.com/questions/107726/how-to-create-animated-gif-images-of-a-screencast


time1=`date | tr -s ' '| cut -d' ' -f4 | sed 's/:/_/g'`
#title=${1:-$time1}


if [ $# -gt 0 ];then
   str=`echo "$@" | sed 's/ /_/g'`
   title="${str}___${time1}"
else
    title="$time1"
fi
echo "title: $title"
echo  "press y to confirm the title for this movie:"
read answer
if [ "$answer" != y ];then
    exit
fi

dir=~/tmp1/animated
if [ ! -d "$dir" ];then
mkdir -p $dir
fi

file_output="$dir/${title}.gif"
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
echo "$cmd_browser"
eval "$cmd_browser"

}

run(){
echo "$cmd_record"
eval "$cmd_record"
}


trap breaking SIGINT

 run
eval "$cmd_browser"
