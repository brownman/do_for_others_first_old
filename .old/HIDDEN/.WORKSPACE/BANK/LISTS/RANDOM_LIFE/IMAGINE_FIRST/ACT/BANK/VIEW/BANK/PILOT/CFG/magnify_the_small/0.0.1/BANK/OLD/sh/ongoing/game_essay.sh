
check_item(){
    local result

    item=$1 #'root'
    group=$2 #"boots roots root"
    #count instances of item in group

    local count=$(echo "$group" | grep -o "$item"   | wc -w )

    result=$( test $count -eq 0  && echo 0 || echo 1 )
    return $result
}

check_subgroup() {
    local number=0
    local group1="$1" #"root boots"
    local group2="$2" #"root boot boots"
    local answer=0 


    for item in $(echo $group1)
    do 
        check_item "$item" "$group2" 
        answer=$?


        if [ $answer = 1 ]
        then
            let "my_score += 1"
        else
            let "my_score -= 1"
        fi



    done

    #return $number

}


check_in_file(){
    local group1="$1"
    local file=$2
    #local item=$1
    #local result=$(cat /tmp/test1 | grep -o "$item" | wc -l)
    local group2=$( cat "$file" )
    check_subgroup "$group1" "$group2"
    #return $?
}
update_score() {
    local group1="$1"
    local file="$2" 
    check_in_file "$group1" "$file"

    # return $?
}

write_essay(){
    echo2 "write essay got: first: $1 | second: $2"
    if [ "$1" != '' ]
    then

        lang="$1"
    fi
    dereference msg_m0 
}
dereference(){
    echo2 "lang: $lang | dir essay: $dir_essay | file5:  $file5"
    local file5="$dir_essay/essay${lang}.txt"
    touch $file5

    msg_m0="start"
    #local score=0
    while [ "$msg_m0" != '' ];do

        y=\$"$1"   # Name of variable (not value!).
        #echo1 $y    # $Junk

        x=`eval "expr \"$y\" "`
        #echo2 $1=$x


        #  say1 "$x"
        #echo1 $str=$x
        # eval "$1=\"Some Different Text \""  # Assign new value.
        echo2 "$file5"


        #local label="_$last_task"
        local label="$my_score"


        answer=$( gxmessage -entry -buttons "$label" -center  -title "$x" -file "$file5" $gxmessage 0 -timeout 20 )

        eval "$1=\"$answer\""  # Assign new value.

        if [ "$answer" != '' ]
        then
            local plus=0
            echo1 'change value of $1'

            echo1 'before update score'
            update_score "$answer" $file5
            echo1 'after update score'
            say2 "$answer" $lang $file5 true
            #sleep2 1s
        fi
    done
}




write_essay #RU #"$LANG_ESSAY"


