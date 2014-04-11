    #export file_vim=$dir_cfg/vimrc.cfg
#help01: \n install bashrc additions \n use environment var: dir_project to load local file:  bashrc.fun
#
test_bashrc_calls_the_project_s_bashrc(){
path="$dir_project"
file_target=~/bashrc-addition
touch $file_target



    local result1=`cat $file_target | grep dir_project`
    if [ "$result1" = '' ];then

echo -n > $file_target
        echo "Installing.."
        echo "export dir_project=$dir_project" >> $file_target
        echo "source \$dir_project/bashrc.fun" >> $file_target
        echo "source \$dir_project/projectrc.fun" >> $file_target
        echo "File: $file_target"
      print_hint "updating $file_target..."
      flite 'updating bash rc additions'
        exiting

       fi



    local result2=`cat ~/.bashrc | grep bashrc-addition`

    if [ "$result2" = '' ];then
           cmd="echo \"source $file_target\" >> ~/.bashrc"

      print_hint 'updating bashrc...'
      flite 'updating bashrc'
        exiting

      fi


    assertNotEqual "${result1}${result2}" ''


}
