#!/bin/bash

# about file:
# extruct yaml to dirs: tmp OR cfg 
file_locker=/tmp/yaml
#delay=9
#unlocker?
#file_locker=/tmp/translation
delay=3
loops=2
gentle=true


notify_send 'yaml.sh' 'start'


parse_subject(){
trace  "parse subject $1"
local subject="$1"
local file_to=$DATA_DIR/tmp/${subject}.tmp
echo '' >  $file_to

local cmd=$( echo "cat $file_data | shyaml get-values $subject" )
local results=$(eval "$cmd")

echo "$results" > $file_to

}

unpack_subject(){
local subject="$1"
local file=$DATA_DIR/tmp/${subject}.tmp
        local lines=()
        file_to_lines $file
    echo -n '' > $file #replace file's content
        local cmd='line_strip "$line" $file'
    execute_lines 
}

show_keys(){
local keys1=$(cat $file_data | shyaml keys)

        IFS='|' read -a columns <<< "$keys1"

        count=0
        for key in ${keys1[@]}; do

        notify_send1 "parse subject: $key" 
parse_subject "$key"

            done


trace "show keys: $keys1"
}
clean_txt_files(){
echo '' > $file_txt_disown
}

run(){

#touch $PROJECT_DIR/genius.sh
cmd1=clean_txt_files
every "$cmd1" 20
show_keys

#cmd1='tasker db update_db_list'
#tasker config notify_send4 "update db" "$cmd1"



cmd1='tasker wallpaper'
tasker config notify_send4 "update wallpaper" "$cmd1"



notify_send 'yaml.sh' 'end'
}
unlocker 
