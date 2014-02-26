#!/bin/bash -e
#echo print_got "road.sh got: $@"
#url:
#http://www.commandlinefu.com/commands/matching/mp3/bXAz/sort-by-votes
if [ ! -d "$dir_workspace" ];then
    
    echo  'no such workspace' "$dir_workspace"
    exit
fi
export file_txt="$dir_workspace/lists/road.txt"
echo $file_txt
if [ ! -f $file_txt ];then
touch $file_txt    
exit 1
else
echo "$file_txt"
cat $file_txt
fi


echo "$0 $@" > $file_txt
path=`dirname $0`
dir_source=${1:-''}
if [ "$dir_source" ];then



    str=`echo $dir_source | sed 's/ /_/g'`
    #str=`echo $str | sed 's/VIDEO/AUDIO/g'`
    str=`echo $str | rev | cut -d'/' -f1 | rev`

    dir_target=/tmp1/AUDIO/$str


    type_source=mp4
    type_target=mp3
    show_env(){
        echo print_status 'show_env:'

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
            size=`du $path_file_new | cut -f1`
            
               if  [ -f "$path_file_new" ] && [ "$size" -lt 1000 ];then
                cmd="rm \"$path_file_new\""
                echo "$cmd"
                eval "$cmd"
                fi

            if [ ! -f "$path_file_new" ];then
            ffmpeg -i "$path_file_old" -acodec libmp3lame -ab 160k -ar 44100 -ac 2 "$path_file_new"
            else
                echo 'skipping creation of already existing file: ' "$path_file_new"
            fi



            touch $path_file_new
            echo print_good "creating ... $path_file_new"

            #for file in *.flac; do flac -cd "$file" | lame -q 0 --vbr-new -V 0 - "${file%.flac}.mp3"; done
        else
            echo print_error "source file is not exist: $path_file_old"
        fi

    }
    url(){
        url=http://www.commandlinefu.com/commands/matching/mp3/bXAz/sort-by-votes
        exo-open $url 
    }
    run(){
        echo print_good run:
        if [ -d "$dir_source" ];then

            files=`ls -1 $dir_source`
            echo "${files}" > /tmp/files
            #echo ${files}
            while IFS= read -r file
            do
                single "$file"
            done < "/tmp/files"
        else
            echo print_error "no such dir $dir_source"
        fi
    }
    show_env
    echo continue?
    read answer
    if [ "$answer" = y ];then
        if [ ! -d "$dir_target" ];then
            echo print_status "creating dir.. $dir_target"
            mkdir -p $dir_target
            ls -l $dir_target
        fi

        if [ "$1" ];then
            echo "$@" >> $path/.history
            run
        else
            echo print_good HISTORY:
            cat $path/.history
        fi
    else
        echo line sh road 
    fi

else
    echo 'supply a directory of videos'
fi

