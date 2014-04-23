#!/bin/bash 

#set -o errexit


notify_send1 "Restart Test"
export  COMMANDER=false
#export DEBUG=true
export VERBOSE=false
result_g='equal'

file_test=/tmp/testing
file_locker='/tmp/test'
delay=1

#(tasker motivation &)
plugin(){
    $PLUGINS_DIR/$1.sh "$2" "$3"

}
#cfg(){
#    notify_send1 'cfg test'
#    #local cmd="$@"
#    #assert_equal_str $cmd
#    #local res=$(    commander "$cmd")
#    #echo "$res"
#    local args=( "$@" )
#    #$(show_args "${args[@]}")
#    local res1=$( "${args[@]}")
#    echo "$res1"
#}
snippet(){
    notify_send1 'cfg test'
    local cmd="$@"
    #assert_equal_str $cmd
    local res=$(    commander "$cmd")
    echo "$res"
}
tasks_sh(){
    #assert_equal_str 'a b' 'a b' 'something went wrong'
    #exiting
    #trace "tasks_sh run: $*"
    #tasker "$@" 
    notify_send1 'tasks_sh test'
    #local cmd="$@"
    local args=( "$@" )

    #local cmd=$(echo "tasker ${args[@]}")
    local cmd="tasker ${args[@]}"
    local res1=$( commander "$cmd" )
    echo  "$res1"
}
update_line(){
    IFS='|' read -a args <<< "$line"
    local line1=$(show_args "${args[@]}")
    #line="$line1"
    echo "$line1"
}


test_yaml(){

            #tasker motivation smaller 
#tasker motivation breath
#sleep1 30
    #tasker cow_report koan  
    reload_cfg
    #trace "tasker"
    local filename=$(get_filename 'txt' 'testing' )
    local line=$(cat $filename | head -1)
    if [ "$line" != '' ];then



        local res="$NO"


local cmd="tasker free_imagination $DATA_DIR/txt/testing.txt"
tasker config notify_send4 "$line" "$cmd"

cmd='tasker motivation'
run_silently "$cmd"
fi
echo 'equal'
}
tesst(){
  #local run1=$( echo "$line" | awk -F '|' '{print $2}' )
            #xdg-open "$run1"

            #new
            local line=$(cat $filename | tail -1)

            #flite "$line"
            messageYN1 "$line" 'add a soldier ?' 
return
            local res=$?
            #if [ $res -eq 1 ];then

                line=$(  tasker db get koan true false )
                #return
                #assert_equal_str "$line" 'line'
                local desc=$( echo "$line" | awk -F '|' '{print $1}' )
                local time=$( echo "$line" | awk -F '|' '{print $2}' )
                local route=$( echo "$line" | awk -F '|' '{print $3}' )
                local method=$( echo "$line" | awk -F '|' '{print $4}' )
                local inputs=$( echo "$line" | awk -F '|' '{print $5}' )
                local expect=$( echo "$line" | awk -F '|' '{print $6}' )

                #assert_equal_str "$line" 'desc|time|route|method|input|expect?'

                #assert_equal_str "$inputs" "inputs"
                local inputs1=$( echo "$inputs" | sed 's/,/ /g' ) 
                route='tasks_sh'
                local cmd=$( echo "$route $method $inputs1" )
                #update_commander
                local result=$(commander "$cmd")
                #remove_commander
                result="$result"

                #assert_not_equal_str "$result" "" 'must not be empty'




                local equality=''
                if [ "$result" != '' ];then

                    equality=$([[ "$result" = "$expect" ]] && echo 'equal' || echo "$result")
                else
                    equality='empty'
                fi


                #tasker db update_table1 koan true true 
                local data="$desc|$time1|$route|$method|$inputs|$expect|$equality"

                local ans=$(tasker db set koan false true "$data" )
                if  [ "$equality" ] && [ "$equality" = 'equal' ];then
                    notify_send3 'test ok!'
                else
                    notify_send1 'google is a friend ?' 'test failed'
                    cmd='notify_send3 " must document the new tests"'
                    (every "$cmd" 5  &)
                fi

                #local ans=$(tasker db update_table koan true "$desc" "$time1" "$route" "$method" "$inputs1" "$expect" "$equality" )
                #local choose_line=$( tasker db show_selected_table koan )

                echo "$equality"

}

run(){
    result_g=$(test_yaml)


}
run
#unlocker

echo "$result_g"






