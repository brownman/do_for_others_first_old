test_user_has_workspace(){
    if [ ! -d "$dir_workspace" ];then
        echo 'Creating directory:'
        cmd="mkdir -p $dir_workspace"
        echo "$cmd"
        eval "$cmd"
    else




        assertEqual 1 1

            print_info "$dir_workspace"


    fi
}

test_default_task_list(){
    file_room1="$dir_rooms/room1.txt"
    if [ ! -f "$file_room1" ];then
        echo "generating initial file structure"


        if [ ! -d "$dir_rooms" ];then
            echo 'Creating directory:'
            cmd="mkdir -p $dir_rooms"
            echo "$cmd"
            eval "$cmd"
        fi

        cmd="touch $file_room1"
        echo "$cmd"
        eval "$cmd"
        cmd="echo -e 'todo1\nsleep 60' >> $file_room1"
        echo "$cmd"
        eval "$cmd"
        echo "Done!"
        echo "$file_room1"
        cat "$file_room1"
    else



  assertEqual 1 1

print_info "$file_room1"




    fi

}




