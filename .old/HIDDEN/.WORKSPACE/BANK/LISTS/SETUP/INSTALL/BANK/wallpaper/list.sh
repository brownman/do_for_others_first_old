#!/bin/bash
#depand_package: image-magic


image_replace(){
    #info: replace xfce4 wallpaper
    #url: "http://www.commandlinefu.com/commands/matching/xfce/eGZjZQ==/sort-by-votes"
    print_func
    local     file=$file_image_big
    if [ -f $file ];then
        xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/image-path -s $file
    else
        echo error - file not exist : $file
    fi

}

image_from_txt(){
    #info: create an image from text

    #http://www.commandlinefu.com/commands/tagged/41/imagemagick/sort-by-votes
    print_func
    file=$file_txt
    cat $file | convert label:@- $file_image
}
image_resize(){
    #info: stretch image and save in a new file
    convert -resize '1080x800^' $file_image $file_image_big
}
image_shadow(){
    #info: add shadow to image
#convert {$file_image_big} \( +clone -background black -shadow 60x5+10+10 \) +clone +swap -background none -layers merge +repage  {$file_image_big_shadow}

montage $file_image_big +clone -clone 0-1 -clone 0-3 -geometry 500 -frame 5 $file_image_big_shadow
#composite -dissolve 30% -tile watermark.png input.png output.png
#convert -font -misc-fixed-*-*-*-*-*-*-*-*-*-*-*-* -fill black -draw "text 270,260 \" `cal` \"" testpic.jpg newtestpic.jpg
}

set_env(){
export file_image=/tmp/file_image.png
    export file_image_big=/tmp/file_image_big.png
    export file_image_big_shadow=/tmp/file_image_big_shadow.png
    export file_txt=/tmp/list.txt

}
use_the_old(){
echo grep1 -lr /backdrop/screen0/monitor0/image-path $dir_root
}
steps(){
    type set_env
set_env
        image_from_txt
    image_resize
    image_shadow
    image_replace
    use_the_old
}
steps
echo $?
