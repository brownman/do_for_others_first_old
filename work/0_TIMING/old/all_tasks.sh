


file=$DATA_DIR/tmp/timer.tmp
#show all tasks
all_lines(){
    #lines=() 
    local from="$1"
    local cmd='notify_send'
    file_to_lines "$from"

    execute_lines
    #local msg=$(    execute_lines )
    #local msg=$(file_to_lines "$from")
    echo "$msg"
    echo "zz"

}
all_lines $file
