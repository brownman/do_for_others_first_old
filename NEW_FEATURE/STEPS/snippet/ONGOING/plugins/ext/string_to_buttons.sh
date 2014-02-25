#!/bin/bash
# about file:
# string to buttons -> choose -> echo -> say

#http://www.thegeekstuff.com/2010/06/bash-array-tutorial/
trace "string_to_buttons.sh got:  $1 "
#arg:$2 3:$3" 
#delimeter='-'
#delimeter=''

empty='Q'
arr=()
declare -a arr=() 
#=('aa')
arr_to_msg(){
    trace arr_to_msg
    local str=$(random_line $file_assosiation)
    #if [ "$STRING_TO_BUTTONS" = true ];then

            gxmessage -buttons "$1" "$str" $GXMESSAGET
          
    #else
        #mantion 'string to buttons is off'
        #gxmessage -buttons "$1" "$str" -timeout 9 -iconic 
    #fi

    local num=$?
    local str="${arr[$num]}"
    green "$str"
    echo "$str"
}



str_to_arr(){
    trace "string_to_arr() got:  1:$1 " 
    str="$1" 

    old_IFS=$IFS
    #show_arr 1
    #read -a arr <<< "$str"
    IFS="$delimeter"

    arr=($(echo "$str"))

    IFS=$old_IFS

}
arr_to_str(){
    trace arr_to_str

    #local str1="$1"
    local item=''
    local item1=''
    for i in "${!arr[@]}"; do
        item=${arr[$i]}
        #item1=$(remove_trailing "$item")
        if [ "$str1" = '' ];then
            str1="$item:$i"
        else
            str1="$str1,$item:$i"
        fi
    done
    #
    #    show_arr1 'string_to_arr() 1' 
    #
    #
    #
    #    trace "$str"
    echo "$str1"

}
step1(){
    local str="$1"
    delimeter="${2:-'-'}"   # Defaults to /tmp dir.
    str_to_arr "$1" #create new array
    local str2=$(arr_to_str ) #use array to create buttons-string
    echo "$str2"
}
act(){
    #local   args=( "$@" )
#local args_str="${args[@]}"
    #assert_equal_str "$args_str" "z"
    local res=''

    delimeter=${2:-' '}   # Defaults to /tmp dir.

    local str="Q${delimeter}$1"

    str_to_arr "$str" #create new array
    local str2=$(arr_to_str ) #use array to create buttons-string
    #echo "$str2"trace "$str2"
    #trace "arr: ${arr[@]}"
    local str3=$(arr_to_msg "$str2")

    local str4=$(remove_trailing "$str3")
    trace "=$str4="
    if [ "$str4" = "$empty" ] 
    then
        trace "choosen: empty string: -$str4-"
    else
        #update_file $file_memory "$str4"

        trace "choosen: $str4"
        res="$str4"
    fi

#assert_equal_str "$res" 'dog'
    echo "$res"


}
#
#COMMANDER=true
#args=( "$@" )
#
#assert_equal_str "$args"
#
##arg1="${args[0]}"
##arg2="${args[1]}"
#arg1=$(echo "$1")
#
##cmd=$(echo "act $1 $2")
##cmd=$(echo "act ${args[@]}")
##cmd=$(echo act "$arg1" "$arg2")
#res=$(commander "$cmd" )
#echo "$res"
#
res1=$(act "$1" "$2")
echo "$res1"

