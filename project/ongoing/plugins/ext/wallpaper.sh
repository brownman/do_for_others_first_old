#!/bin/bash
#about file: user yaml category: wallpaper for generating new desktop background
#dependencies: imagemagic
#utilize: one.yaml , data/tmp/wallpaper.tmp
####  ###  ##  ##  ###
#ref:
#imagemagic
#http://www.imagemagick.org/Usage/text/#pango_markup

notify_send1 'wallapaper' 'plugin'

file_original=/usr/share/xfce4/backdrops/xubuntu-precise-right.png
file_before=/tmp/before.png #copy of the original
file_after=/tmp/after.png #compose: txt_image + background
file_text_image=/tmp/text.png #convert txt to image
file_tmp=$DATA_DIR/tmp/wallpaper.tmp

amount=4

run(){
    #efficiency_image
    backup
    #show $file_before

    #gedit $file_txt
    trigger
   

    replace
 cmd="xloadimage $file_after"
    optional1 "$cmd"
}
#efficiency_image(){
#    #http://www.imagemagick.org/Usage/text/#pango_markup
#    local file_txt=$DATA_DIR/pango/text_data.txt
#    local file_image=/tmp/text_layered.jpg
#
#    cat $file_txt |
#    while read width gravity color  pointsize x y text
#    do
#        convert -size ${width}x -gravity $gravity -fill $color -background wheat \
#            -pointsize $pointsize  -page +${x}+${y}  label:"${text}"  miff:-
#    done |
#    convert -size 200x100 xc:   -   -flatten    $file_image
#    local cmd="xloadimage $file_image"
#    detach "$cmd"
#}

parse_line_of_wallpaper(){

    local filename=$( echo "$line" | awk -F ' ' '{print $1}' )
    local file_txt=$DATA_DIR/log/$filename.log

trace parse_line_of_wallpaper "$filename"
    is_valid $file_txt
    res=$?
    if [ $res -eq 1 ];then

        notify_send " file ok" "$file_txt"
        local x=$( echo "$line" | awk -F ' ' '{print $2}' )
        local y=$( echo "$line" | awk -F ' ' '{print $3}' )
        local size=$( echo "$line" | awk -F ' ' '{print $4}' )
        local point_size=$( echo "$line" | awk -F ' ' '{print $5}' )
        local color=$( echo "$line" | awk -F ' ' '{print $6}' )
        local override=$( echo "$line" | awk -F ' ' '{print $7}' )
        local cmd1="generate $file_after $file_txt $x $y $size $point_size $color $override"
        #echo "$cmd1"
        #update_commander
        commander "$cmd1"
        #generate $file_before $file_txt 1130 150 600x 13 white true
    else
        notify_send "invalid file" "$file_txt"
    fi

}


trigger(){
    trace trigger
    lines=()
    file_to_lines $file_tmp
    trace "lines: ${lines[@]}"
    local cmd='parse_line_of_wallpaper'
    execute_lines
}

generate(){
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
    #generate text:
    cat  $text_file | head -$amount |    convert -background none  -fill $color -size $size  -pointsize $point_size caption:@-  $file_text_image
    composite -geometry "+$x+$y" $file_text_image $background $file_after 
}

playground(){
    #generate static:
    text_image=/tmp/text.png
    if [[ $override = 'true' ]]
    then
        result=/tmp/result.png
    else
        cp /tmp/result.png /tmp/temp.png
        result=/tmp/temp.png
    fi
}
backup(){
    notify_send1 'backup'
    #src=xfce-transparent.png
    #file1="/usr/share/xfce4/backdrops/${src}"
    #file1="/tmp/mm.png"
    #usr/share/xfce4/backdrops/${src}"
    #cp ~/Pictures/lubuntu-default-wallpaper-2.png /tmp/result.png

    cp $file_original $file_before
    cp $file_before $file_after
}
replace(){
    #update xfce desktop
    notify_send1 'update wallaper' 
    xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/image-path -s ~/Pictures/lubuntu-default-wallpaper-2.png 
    sleep1 4
    xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/image-path -s $file_after
    xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/image-path -s $file_after
}
show(){
    result=$1
    xloadimage $result
}













run
