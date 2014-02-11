    #export file_vim=$dir_cfg/vimrc.cfg
#help01: \n install bashrc additions \n use environment var: dir_project to load local file:  bashrc.fun
#
test_bashrc_calls_the_project_s_bashrc(){
path="$dir_root"
file_target=/tmp/bashrc-addition
touch $file_target
echo -n > $file_target
    local result=`cat ~/.bashrc | grep dir_root`

    if [ "$result" = '' ];then
        echo "Installing.."
###
        echo "export dir_root=$dir_root" >> $file_target

        echo "source \$dir_root/bashrc.fun" >> $file_target
        echo "source \$dir_root/projectrc.fun" >> $file_target
###
        echo "File: $file_target"
        cat $file_target
        cmd="cat $file_target >> ~/.bashrc"
        confirm "$cmd"
        print_hint 'run: bash and try again'
        exiting
    fi

    assertNotEqual "$result" ''


}
