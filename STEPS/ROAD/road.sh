#!/bin/bash -e
print_got "road.sh got: $@"
#url:
#http://www.commandlinefu.com/commands/matching/mp3/bXAz/sort-by-votes


path=`dirname $0`
dir_source=$1


str=`echo $dir_source | sed 's/ /_/g'`
#str=`echo $str | sed 's/VIDEO/AUDIO/g'`
str=`echo $str | rev | cut -d'/' -f1 | rev`

dir_target=$dir_dropbox/AUDIO/$str


type_source=mp4
type_target=mp3
show_env(){
    print_status 'show_env:'

    echo path: $path 
    echo dir_source: $dir_source
    echo dir_target: $dir_target

    echo type_source: $type_source
    echo type_target: $type_target
}
single(){
    filename="$1"
    path_file_old="$dir_source/$filename"

    if [ -f "$path_file_old" ];then
        local filename_new=`echo "$filename" | sed 's/ /_/g'`
        #filename_new=`echo "$filename_new" | sed 's/$type_source/$type_target/g'`

        path_file_new="$dir_target/$filename_new.$type_target"
        echo -e "create this file? $path_file_new"


        #ffmpeg -i $path_file_old -vn -ar 44100 -ac 2 -ab 192k -f $path_file_new
        #ffmpeg -vcodec copy -acodec copy -i orginalfile -ss 00:01:30 -t 0:0:20 newfile
        ffmpeg -i "$path_file_old" -acodec libmp3lame -ab 160k -ar 44100 -ac 2 "$path_file_new"


        touch $path_file_new
        print_good "creating ... $path_file_new"

        #for file in *.flac; do flac -cd "$file" | lame -q 0 --vbr-new -V 0 - "${file%.flac}.mp3"; done
    else
        print_error "source file is not exist: $path_file_old"
    fi

}
url(){
    url=http://www.commandlinefu.com/commands/matching/mp3/bXAz/sort-by-votes
    exo-open $url 
}
run(){
    print_good run:
    if [ -d "$dir_source" ];then

        files=`ls -1 $dir_source`
        echo "${files}" > /tmp/files
        #echo ${files}
        while IFS= read -r file
        do
            single "$file"
        done < "/tmp/files"
    else
        print_error "no such dir $dir_source"
    fi
}
show_env
echo continue?
read answer
if [ "$answer" = y ];then
    if [ ! -d "$dir_target" ];then
        print_status "creating dir.. $dir_target"
        mkdir -p $dir_target
        ls -l $dir_target
    fi

    if [ "$1" ];then
        echo "$@" >> $path/.history
        run
    else
        print_good HISTORY:
        cat $path/.history
    fi
else
   echo line sh road 
fi

