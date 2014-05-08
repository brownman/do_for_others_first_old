#!/bin/bash

# about file:
# update desktop wallpaper
# background: is the mindmap.png | mm.png
#  
#
#
. $TIMERTXT_CFG_FILE






tpng=$TASKS_DIR/txt_to_png.sh

points_txt=/tmp/points.txt

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





text_file=~/tmp/timer2/daily/todo.txt
#gedit $text_file
$tpng $background $text_file 450 200 800x 13 yellow true

text_file=~/tmp/timer2/daily/done.txt
#gedit $text_file
$tpng $background $text_file 90 630 1300x 15 white true

text_file=/tmp/gcalcli_agenda.txt
$tpng $background $text_file 40 150 600x 13 white true

text_file=/tmp/missions.txt
#tmp/ofer/daily/now.txt
$tpng $background $text_file 1130 150 600x 13 white true

text_file=/tmp/date.txt
$tpng $background $text_file 90 1000 400x 70 yellow true

cat $motivations_txt | head -1 > $motivation_txt
text_file=$motivation_txt
$tpng $background $motivation_txt 770 140 500x 33 black true
$tpng $background $motivation_txt 800 160 500x 33 grey true
$tpng $background $motivation_txt 830 180 500x 33 orange true






