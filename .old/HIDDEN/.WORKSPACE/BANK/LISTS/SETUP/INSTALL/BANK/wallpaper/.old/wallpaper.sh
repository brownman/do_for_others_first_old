#!/bin/bash  -e
set +o nounset
#about file: user yaml category: wallpaper for generating new desktop background
#dependencies: imagemagic
#utilize: one.yaml , data/tmp/wallpaper.tmp
####  ###  ##  ##  ###
#ref:
#imagemagic
#http://www.imagemagick.org/Usage/text/#pango_markup

notify-send 'wallapaper' 'plugin'
exports(){
print_func
file_original=/tmp/xfce.png
#/usr/share/xfce4/backdrops/xubuntu-precise-right.png
file_before=/tmp/before.png #copy of the original
file_after=/tmp/after.png #compose: txt_image + background
file_text_image=/tmp/text.png #convert txt to image
file_tmp=/tmp/wallpaper.tmp
amount=4
}

trigger(){
    trace trigger
    lines=()
    echo file_to_lines $file_tmp
    echo trace "lines: ${lines[@]}"
    local cmd='parse_line_of_wallpaper'
   echo  execute_lines
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
    notify-send 'backup'
    #src=xfce-transparent.png
    #file1="/usr/share/xfce4/backdrops/${src}"
    #file1="/tmp/mm.png"
    #usr/share/xfce4/backdrops/${src}"
    #cp ~/Pictures/lubuntu-default-wallpaper-2.png /tmp/result.png

    cp $file_original $file_before
    cp $file_before $file_after
}
show(){
    result=$1
    xloadimage $result
}











steps(){
    print_func
$sh_coverage    exportsi
    #efficiency_image
$sh_coverage    backup
    #show $file_before

    #gedit $file_txt
$sh_coverage    trigger
   

$sh_coverage    replace
}
# cmd="xloadimage $file_after"
#    echo optional1 "$cmd"


steps
set +o nounset
