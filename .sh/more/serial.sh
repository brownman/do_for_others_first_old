# about file:
# run circle of tasks: 
# input: workflow.txt
# execute: tasks.sh $workflow
#



trace "serial.sh got: 1:$1 2:$2"
report(){
   $( messageYN1 "report:" ' are you effective ? '  )
    local result1=$?
    if [ $result1 -eq "$YES" ];then

        #update_file $file_logger
        local str="$str_tasks"
    tasker update_points "$str"

    fi
}
level(){
    $( tasker config level $max )
#assert_equal_str "$max_efficiency"
    if [ $max_efficiency = '' ];then
exiting
    fi
    if [ $max_efficiency -eq 0 ];then

optional1        "gedit $DATA_DIR/yaml/one.yaml"
        exiting
    fi


}
efficiency(){
    if [ $count -gt  $max_efficiency  ];then
            flite 'efficiency level is smaller than counter'
            break
        fi
}
ensure(){
    $(messageYN1 "$str_file_workflow" 'ensure this workflow:')
local res_fyn=$?
if [ $res_fyn -eq $NO ];then
    $TIME_DIR/yaml.sh
exiting
else
    notify_send1 'continue' 
    #'to first task'
fi


}


read_lines(){
    trace "read_lines() got:  1:$1 2:$2"


    local args=''

    while read -r line
    do


        [[ $line = \#* ]] && continue
        #echo "$line"
        #lines=("${lines[@]}" "$line")
        if [ "$line" != ''  ];then
            #echo "line: $line"
            lines+=("$line")
        fi
    done < $file_workflow

    #gxmessage -file $file_workflow "$GXMESSAGET" -title 'ensure this workflow:'
    local str_file_workflow=$(cat $file_workflow)
    local max=${#lines[@]}
    local max_efficiency=max
    count=1
    local str_tasks=''
    for line in "${lines[@]}"
    do
        notify_send1 'continue on moving your ass around'
        local str_percent="$count of $max_efficiency"
        local     action=$( echo "$line" | awk -F '|' '{print $1}' )
        local     desc=$( echo "$line" | awk -F '|' '{print $2}' )

        #$( messageYN1 "$desc" 'action:'  )
        #local result=$?
        local result=$YES
        if [[ $result -eq $YES ]];then
            str_tasks="$str_tasks _ $count: $action"
            notify_send1 "$str_percent"
            notify_send1 "TASK: $desc"
            flite "$desc" true 
            local args=( ${action} )
            local res1=$(  "${args[@]}" )
            notify_send1 'next' 'task' 
            sleep1 60
            let "count=count+1"
        else
            flite 'breaking'
            break
        fi
    done
    tasker motivation sport
}
read_lines

