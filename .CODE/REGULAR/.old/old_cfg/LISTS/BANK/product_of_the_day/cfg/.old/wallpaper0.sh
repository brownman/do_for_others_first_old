#!/bin/bash

# about file:
# update desktop wallpaper
# background: is the mindmap.png | mm.png
#  
#
#
. $TIMERTXT_CFG_FILE






tpng=$TASKS_DIR/txt_to_png.sh

#points_txt=/tmp/points.txt

src=xfce-transparent.png
file1="/usr/share/xfce4/backdrops/${src}"
#file1="/tmp/mm.png"
#usr/share/xfce4/backdrops/${src}"
#cp ~/Pictures/lubuntu-default-wallpaper-2.png /tmp/result.png
cp $file1 /tmp/result.png
#str=$(head -4 /tmp/gcalcli_agenda.txt | tail -3)

#echo -e "$str" > /tmp/next.txt

date | awk -F ' ' '{print $4}' > /tmp/date.txt
background=/tmp/result.png
text_file=txt/todo.txt
#text_file=~/tmp/timer2/daily/todo.txt
#text_file=/tmp/gcalcli_agenda.txt
#text_file=~/tmp/timer2/daily/done.txt
$tpng $background $text_file 450 200 800x 13 yellow true
$tpng $background $text_file 90 630 1300x 15 white true
$tpng $background $text_file 40 150 600x 13 white true
$tpng $background $text_file 1130 150 600x 13 white true
$tpng $background $motivation_txt 770 140 500x 33 black true
$tpng $background $motivation_txt 800 160 500x 33 grey true
$tpng $background $motivation_txt 830 180 500x 33 orange true






