#!/bin/bash -e


#export dir_base=$dir_root
export dir_self=`dirname $0`
#export dir_base=`pwd`
file=''
args=$1
level=0
util=$dir_self/run.sh
if [ ! -f "$util" ];then
    reason_of_death file "$util"
    exiting
fi

folder=~/Desktop/$day 
if [ ! -d "$folder" ];then
    mkdir $folder
else
    echo "already exist: $folder"
fi



is_valid_file(){
    http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_01.html
}
is_valid_array(){
    http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_10_02.html
    http://www.thegeekstuff.com/2010/06/bash-array-tutorial/
}
type_of(){
    http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_10_01.html
}
choose_level(){
    print_status choose_level
    #prompt for input
    if [ "$args" ];then
        level=$args
    else
        echo  'Please supply productivity level'
        read level
    fi
}
file_to_array11(){
    {
        IFS=\$
        lines=( $(cat -E $file) )
    }
}
file_to_array2(){
    lines=( $(cat $file) ) ## no quotes
}
file_to_array(){
    print_status "use:  file, lines"
    if [ ! -f "$file" ];then
        eval reason_of_death file "$file"
    fi
    if [ ! -a "$lines" ];then
        eval reason_of_death line "$lines"
    fi

    lines=()
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
    done < $file
    echo "generated: array name: lines()"
    #    echo "${lines[@]}"
    printf "%s\n" "${lines[@]}"


}

set_file(){
    print_status "level choosed: $level"
    file=$dir_self/rooms/room$level.txt
    if [ -f $file ];then
        print_good "$file exist!"
    else
        reason_of_death "file" "$file"
    fi
}

execute_lines(){
    local file1=''
    num=${#lines[@]}
    print_status "execute $num tasks ?"

    read answer
    if [ "$answer" = y ];then
        local res=''
        rounds=1
        while true;do
            file1=$folder/$rounds.txt
            if [ ! -f $file ];then
                touch $file1
            fi
            for line in "${lines[@]}"
            do
                print_good "Next Task: $line"
                if [ "$line" ];then
                    cmd="$util $line"
                    print_call "call: $cmd"
                    set +x
                    eval "$cmd"
                    #echo "$cmd"
                else
                    print_error 'no line givven'
                fi
            done
                xcowsay "$rounds rounds!"
                let 'rounds += 1'
        done
    fi


}


run(){
    #set int:level ( from user's feelings )
    choose_level

    #set file ( use: level for choosing a file which consist of tasks )
    set_file

    #update array:lines ( from file's lines )
    file_to_array


    ############
    #loop: execute each line of lines()
    execute_lines
    ############
}
run

