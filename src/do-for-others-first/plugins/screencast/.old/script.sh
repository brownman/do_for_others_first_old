#!/bin/bash -e
#http://askubuntu.com/questions/107726/how-to-create-animated-gif-images-of-a-screencast
file_output=/tmp/file.gif

cases1(){
cmd1="ffmpeg -f x11grab -r 25 -s 800x600 -i :0.0 $file_output"

cmd2="ffmpeg -y -f alsa -ac 2 -i pulse -f x11grab -r 30 -s `xdpyinfo | grep 'dimensions:'|awk '{print $2}'` -i :0.0 -acodec pcm_s16le output.wav -an -vcodec libx264 -vpre lossless_ultrafast -threads 0 $file_output"

cmd3="ffmpeg -f x11grab -s `xdpyinfo | grep 'dimensions:'|awk '{print $2}'` -r 25 -i :0.0 -sameq $file_output > /root/howto/capture_screen_video_ffmpeg"

cmd4="xvidcap --file $file_output --fps 15 --cap_geometry 1680x1050+0+0 --rescale 25 --time 200.0 --start_no 0 --continue yes --gui no --auto"

cmd5="ffmpeg -f alsa -itsoffset 00:00:02.000 -ac 2 -i hw:0,0 -f x11grab -s $(xwininfo -root | grep 'geometry' | awk '{print $2;}') -r 10 -i :0.0 -sameq -f mp4 -s wvga -y $file_output"
}

test1(){


    cmd="\$cmd$1"

    echo "test()" 
    echo "$cmd"
    eval `echo $cmd`
}
root1(){
if [ "$1" ];then
    arg="$1"
    test $arg
else
    cat $0 | grep cmd
fi
}

breaking(){
echo Breaking..
echo "file_output: $file_output"
google-chrome $file_output
}

run(){
cmd1="byzanz-record --duration=15 --x=0 --y=0 --width=1280 --height=800 $file_output"
}



trap breaking SIGINT

