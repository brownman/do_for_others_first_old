#!/bin/bash -e
#help.sh:   run tasks in a loop, steps
#option.sh: e.g: adding new room: rooms/room4.txt and than executing script: suspend.sh


#export dir_base=$dir_root
export dir_self=`dirname $0`
#export dir_base=`pwd`
file=''
args=$1
level=0
util=$single_sh
if [ ! -f "$util" ];then
    reason_of_death 'script not found' "$util"
fi
if [ "$DESKTOP" = true ];then
folder=~/Desktop/$day 
if [ ! -d "$folder" ];then
    mkdir $folder
else
    echo "already exist: $folder"
fi
fi



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

file_to_array(){
    print_status "use:  file, lines"
    if [ ! -f "$file" ];then
         reason_of_death file "$file"
    fi
    if [ ! -a "$lines" ];then
         reason_of_death line "$lines"
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
    file=$dir_rooms/room$level.txt
    if [ -f $file ];then
        print_good "$file exist!"
    else
        reason_of_death file "$file"
    fi
}
update_desktop(){
           if [ "$DESKTOP" = true ];then
            file1=$folder/$rounds.txt
            if [ ! -f $file1 ];then
                touch $file1
            fi

            fi

}
execute_lines(){
    print_func
    local file1=''
    num=${#lines[@]}
    print_status "execute $num tasks ?"

    read answer
    if [ "$answer" = y ];then
        local res=''
        rounds=1
        while :;do
             for line in "${lines[@]}"
            do
                echo "Next Task: $line"
                if [ "$line" != '' ];then
                    cmd="$util $line"
                    
                    commander "$cmd"
                else
                    reason_of_death 'empty line'
                fi
            done
                echo xcowsay "$rounds rounds!"
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

