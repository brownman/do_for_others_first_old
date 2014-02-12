#!/bin/bash

# about file:
#  
#
#


. $TIMERTXT_CFG_FILE

echo 'generate new text on the background'
echo -e "background:$1 \n text_file:$2 \n x:$3 y:$4 \n size:$5 \n point_size:$6"
background=$1 # /tmp/background.png
text_file=$2 #  /tmp/next.txt 
x=$3 #850
y=$4  #350
size=$5 #200x
point_size=$6 #25
color=$7
override=$8

#generate static:
text_image=/tmp/text.png
if [[ $override = 'true' ]]
then
result=/tmp/result.png
else
cp /tmp/result.png /tmp/temp.png
result=/tmp/temp.png
fi



#generate text:
cat $text_file |    convert -background none  -fill $color -size $size  -pointsize $point_size caption:@-  $text_image

#merge background+text to result.png
composite -geometry "+$x+$y" $text_image $background $result 
cp ${result} ~/Pictures/result.png

#update xfce desktop
xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/image-path -s ~/Pictures/lubuntu-default-wallpaper-2.png 
xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/image-path -s ~/Pictures/result.png

#xloadimage $result

