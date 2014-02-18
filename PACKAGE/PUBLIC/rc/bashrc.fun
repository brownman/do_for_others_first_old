#export SUCCESS=1
#export FAILURE=0
<<ABC
echo 'line: I am not getting printed! '
question: how to print the exported function?
dao04@localhost:~/JAIL$ type tree1
tree1 is a function
tree1 () 
{ 
    tree > /tmp/tree.txt;
    cat /tmp/tree.txt;
    echo 'create new file? .tree ?';
    read answer;
    if [ "$answer" = y ]; then
        cat /tmp/tree.txt >> .tree;
    fi
}
ABC

if [ $dir_rc = '' ];then
    echo "\$dir_rc  - not defined"
    exit
fi
dir_lib=$dir_rc/bashrc


source $dir_lib/proxy.cfg
source $dir_lib/eval.cfg
source $dir_lib/alias.cfg
source $dir_lib/fs.cfg
source $dir_lib/general.cfg
source $dir_lib/grep.cfg
source $dir_lib/history.cfg
source $dir_lib/menu.cfg
source $dir_lib/project.cfg

source $dir_lib/rm.cfg
source $dir_lib/prompt.cfg

#export PROMPT_COMMAND='history -a'


#alias single1="$dir_root/breath.sh project/bin/single.sh"
#export BASHRC_LOADED=true
echo "LOADING: bashrc.fun"

#exist(){
#cmd="$1"
#type $cmd >/dev/null 2>&1 || { echo -e >&2 "false" ;}
#}
#export -f exist 
#
#

#
update_dir(){
    dir="$1"
    file="$2"
    text="$3"

    if [ ! -d "$dir" ];then
        mkdir $dir
        echo -e "$text" >> $dir/$file
    else
        echo "dir  already Exist:  $dir"
        update_file "$dir/$file" "$text"
    fi
}

update_file(){
    file="$1"
    text="$2"

    if [ ! -f "$file" ];then
        touch $file
        echo -e "$text" >> $file
    else
        echo "file already Exist:  $file"
    fi
}

scaffold(){
    str_bash="#!/bin/bash"
    echo 'scaffolding..'
    ###################### cfg / global funcs (2)
    ###################### scripts:  (3)
    # wrapper: play all tools
    # test:    self test/present/check/validate/help/info
    # script:  the simplest/cleanest snippet of code
    #####################
    #
    #
    #
    ############################# ignore commiting a local trash folder: plugin/.old/ignore_files_in_this_dir
    file=.gitignore
    text=".old"
    update_file "$file" "$text"
    ##########################################################################


    ######################################### update the scripts: wrapper.sh + script.sh + test.sh
    func1=check_X
    file=test.sh
    text="$str_bash\n\n\n\n${func1}(){\n echo '${func1}()'\n}\n\n\n${func1}" 
    update_file "$file" "$text"

    func1=steps
    file=wrapper.sh
    text="$str_bash -e\nset -o nounset\n\n\n\n${func1}(){\n \
        echo '${func1}()'\n}\n\n\n${func1}"
    update_file "$file" "$text"

    func1=snippet_X
    file=script.sh
    text="$str_bash\n\n\n\n${func1}(){\n \
        echo '${func1}()'\n}\n\n\n${func1}" 
    update_file "$file" "$text"


    ##########################################  update the configuration files: helpers.cfg + vars.cfg
    file=helpers.cfg 
    text="func(){\necho 'func()'\n}\n\nexport -f func"
    update_file "$file" "$text"

    file=vars.cfg
    text="export VAR=''" 
    update_file "$file" "$text"

    ####################################################### add README.md to each plugin + add screencast for a nice presentation which explains: how-to-use the plugin
    ################### add directories:
    dir='.GIF'
    file=demo1.gif
    text=''
    update_dir "$dir" "$file" "$text"

    dir='.HTML'
    file=index.html
    text=''
    update_dir "$dir" "$file" "$text"

    dir='.SNIPPET'
    file=script.sh
    text=''
    update_dir "$dir" "$file" "$text"

    dir='.old'
    file=script.sh
    text=''
    update_dir "$dir" "$file" "$text"
    ############################




    file=README.md
    name0=`pwd`
    name=`basename $name0`
    text="$name\n====\n![demo1](./PRESENTATION/demo1.gif)"
    update_file "$file" "$text"

    ###################################################### update permissions : user is allowed to execute the .sh files
    echo "HINT: test it with:     grep -rn '' ."
    chmod u+x script.sh
    chmod u+x wrapper.sh
    chmod u+x test.sh

}

export -f scaffold
export -f update_file
export -f update_dir

