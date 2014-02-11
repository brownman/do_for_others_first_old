test_create_shortcut(){
    file_link=~/Desktop/WORKSPACE 
   [  -h $file_link ] && result=0 || result=1 
    if [  $result -eq 1  ];then
        print_hint Create symlink to workspace in the Desktop
        ln -s $dir_workspace $file_link
    else
        print_hint 'symlink already exist on the Desktop'
        echo "$file_link"
    fi

    assertEqual "$result" 1
    print_info "$file_link"


}


