#http://sql.learncodethehardway.org/book/
#http://www.tutorialspoint.com/sqlite/sqlite_indexes.htm
#http://www.compileonline.com/execute_bash_online.php
#http://www.thegeekstuff.com/2010/06/bash-array-tutorial/
#http://stackoverflow.com/questions/13470413/bash-array-to-delimited-string?rq=1


#http://sql.learncodethehardway.org/book/ex0.html
#file_db=/tmp/test.db
#table1=memos
#file_db=$dir/test.db 


#
counter(){
    local table=$1
    local res=$(select_from_table $table)
    #local num=$?
    #echo "$res"
    local num=$(echo "$res" | wc -l)
    echo $num
    #assert_equal_str "$res"
}


select_from_table(){
    local    table=$1 
    local res=$(sqlite3 -csv $file_db "select * from $table order by id desc;")
    echo "$res"


}


insert_values_str(){
    #update_commander
    notify_send 'insert values_str' "$1 | $2"
    local name="$1"
    local table1="$name"
    local  file_db=$file_db
    #SQL_DIR/$name.db 

    local fields=$(echo "($2)" | sed 's/ /,/g')
    #assert_equal_str "$fields"
    #local tmp3=$(echo "$3" | sed "s/'/\\\'/g" )

    #local tmp3=$(add_backslash "$3")
    local values="$3"

    local values=$(remove_char "$values" "'")
    #local values=$(remove_char "$values" \")
    #assert_equal_str "$tmp3"
    local values=$(echo "('$values')" | sed "s/|/','/g")
    #local values=$(echo "('$values')" | sed "s/'/\\\'/g")
    #local fields1='(doing,should,sport)'
    #local values1="('a a','b','1')"
    #local cmd=$(echo "sqlite3 $file_db  \"insert into $table1 $fields values $fields\";")
    local cmd=$(echo "sqlite3 $file_db  \"insert into $table1 $fields values $values\";")
    #COMMANDER=true
    local res=$(   commander "$cmd")
    trace "res: $res"
}

update_db_list(){

    local file_db=$file_db
    local file_new=$DATA_DIR/txt/db.txt
    notify_send1 'update_db_list'
    #local str=$(sqlite3 -header -list ex1.db ".tables" | xargs echo | sed 's/ /|/g')
    local str=$(sqlite3 -header -list $file_db ".tables" | tr -s ' ' '\n')
    echo "$str" > $file_new

    #mantion_file $file_new 20
    #assert_equal_file "$file_new"

    echo "$str"
}





show_selected_table(){

    local cmd=''
    local gui=true


    local table1="$1"
    local name="$1"

    #assert_equal_str "$table1"
    local  file_db=$file_db
    notify_send 'show_selected_table:' ": $table1"


    local zen1="--width=1280 --height=800 --list --title=$table1"
    local zen2=''


    local header=$(sqlite3 -header -list $file_db "select * from $table1;" | head -n 1)

    IFS='|' read -a columns <<< "$header"
    fields=(${columns[@]})
    unset fields[0]
    fields="${fields[@]}"

    count=0
    for col in ${columns[@]}; do
        zen1="$zen1 --column=\"$col\" "

        if [ $count -eq 0 ];then
            trace 'skip id'

        else
            zen2="$zen2 --add-entry=\"$col\" "

        fi

        let 'count=count+1'
    done


    local str1="'select * from $table1 order by id desc;'"
    local pipe1=" tr ','  ' ' " 
    local pipe2=" tr '\n' ' ' "
    local str_sql1="sqlite3 -csv $file_db $str1 | $pipe1 | $pipe2"
    local cmd_sql1=$(echo "$str_sql1")
    local res_sql1=$(commander "$cmd_sql1")
    local str_zen1="xargs zenity $zen1 $timeout1 --print-column=ALL"
    #    commander "$str_zen1"
    res=$(echo "$res_sql1" |   eval "$str_zen1")
    echo "$res"
}

#get_column_number(){
#    local table1="$1"
#    local header=$(sqlite3 -header -list $file_db "select * from $table1;" | head -n 1)
#    IFS='|' read -a columns <<< "$header"
#    trace "${columns[@]}"
#    max=${#columns[@]}
#    let 'max=max-1'
#    return $max
#}
get(){
    notify_send 'get last record' '!'
    local table="$1"
    local gui=${2:-'true'}
    local update=${3:-'true'}
    local values_str="$4"
    local values_arr=()

    notify_send "gui" "$gui"
    notify_send "update" "$update"
    local num=0
    local max=0
    local header=''
    if [  ! "$values_str" ];then
        values_str=$(sqlite3 -header -list $file_db "select * from $table;" |  tail -1 )
    fi

    echo "$values_str"





}

set(){
    notify_send 'add new row' '!'
    local table="$1"
    local gui=${2:-'true'}
    local update=${3:-'true'}
    local values_str="$4"
    local values_arr=()


    notify_send "gui" "$gui"
    notify_send "update" "$update"
    local num=0
    local max=0
    local header=''







    #for values
    IFS='|' read -a values_arr <<< "$values_str"
    #for columns
    header=$(sqlite3 -header -list $file_db "select * from $table;" | head -n 1)
    IFS='|' read -a columns_arr <<< "$header"
    columns_arr=("${columns_arr[@]:1}") #removed the 1st element
    columns_str="${columns_arr[@]}"


    if [ "$gui" = true ];then
        values_str=$(show_entry)
        values_str=$(remove_last_char "$values_str")
        IFS='|' read -a values_arr <<< "$values_str"
    else
        delimeter='|'
        arr=("${values_arr[@]}") #removed the 1st element
        values_str=$(    arr_to_str  )
        #IFS='|' read -a values_arr <<< "$values_str"
    fi

    if [ "$update" = true ];then

        num=${#values_arr[@]}
        max=${#columns_arr[@]}

        #assert_equal_str "$values_str" #'values str'
        #assert_equal_str "$num $max" 'num max'
        if [ $num -eq $max ];then
            cmd="insert_values_str \"$table\" \"$columns_str\" \"$values_str\""
            commander  "$cmd"
            cmd="show_selected_table $table"
            ( every "$cmd" 1 &)
        else
            gxmessage $GXMESSAGET -title 'predict: error' "num:$num max:$max values_str:$values_Str"
            breakpoint
        fi


    else
        echo "$values_str"
    fi





}

args=( "$@" )
$(show_args "${args[@]}")
res1=$( "${args[@]}" )
echo "$res1" #must echo for testing to work


