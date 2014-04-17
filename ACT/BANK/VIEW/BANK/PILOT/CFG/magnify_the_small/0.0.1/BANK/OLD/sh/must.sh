notify_send1  'plugin:' 'must' 

run(){
    local file=$DATA_DIR/tmp/must.tmp
    while read -r line
    do
        [[ $line = \#* ]] && continue
        if [ "$line" != ''  ];then
            arr+=("$line")
        fi
    done < $file
    local str=$(check_boxes)
    if [ "$str" ];then
        tasker update_points "$str"
        #echo "$str"


        #update_commander
        IFS='|' read -a lines <<< "$str"
        for line in "${lines[@]}"
        do

            detach "$line"
        done
    else
        cmd="gedit $file_data"
        optional1 "$cmd" 'update must tasks' 'error'
    fi

    echo "$str"
}



run
