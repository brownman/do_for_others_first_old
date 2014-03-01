#!/bin/bash
# about file:
# copyrights:
# https://github.com/darxx/youtube-dl-gui

url='https://www.youtube.com/watch?v=C9PBsVsG_80'
menu(){
user_input=$( zenity --list \
	--text="Youtube Download Menu" \
	--name="Youtube Download Menu" \
	--hide-column="1" \
	--column="" \
	--column="" \
	1 "Youtube List - download to video" \
	2 "Youtube List - download to audio" \
	3 "Single Youtube - download to audio" \
	4 "Single Youtube - download to video" \ )
case $user_input in
    1 )
       ./sh/youtube_list_video
       ;;
    2 )
       ./sh/youtube_list_audio
       ;;
    3 )
       ./sh/youtube_audio
       ;;
    4 )
       ./sh/youtube_video
       ;;
    * )
       exit;
esac
}
step1(){

local riper=$url


    cd /tmp

    (youtube-dl -c -t "$riper"  --no-part --console-title --extract-audio --audio-format mp3 --audio-quality 192k | gawk 'BEGIN { RS="\r" } /%/ { print gensub(/.*(\<.?.?.\..\>)%.*/, "\\1", ""); fflush(); }' ) | zenity --progress --percentage=0 --percentage=0 --auto-close --auto-kill
#youtube-dl -t "$riper"  --no-part --console-title --extract-audio --audio-format mp3 --audio-quality 192k | zenity --progress --percentage=0 --percentage=0 --auto-close --auto-kill
#zenity --progress --percentage=0 --percentage=0 --auto-close --auto-kill
#| gawk 'BEGIN { RS="\r" } /%/ { print gensub(/.*(\<.?.?.\..\>)%.*/, "\\1", ""); fflush(); }' ) | 
#zenity --progress --percentage=0 --percentage=0 --auto-close --auto-kill


file_name=$(ls *.mp3)
file_size=$(du -h $file_name | awk '{print $1}')

notify_send -t 700 -i youtube "Downloaded " "\n `ls *.mp3|awk '{ gsub(/\_/, " "); print }'` \n------------------------------------------------------------------------ \n "Size:" $file_size"
mv *.mp3 /TORRENTS/MP3



}
step1
#eval "$1" '"$2" "$3"'
