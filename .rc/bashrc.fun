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

if [ $dir_rc0 = '' ];then
    echo "\$dir_rc0  - not defined"
    exit
fi
dir_bashrc=$dir_rc0/bashrc


source $dir_bashrc/proxy.cfg
source $dir_bashrc/eval.cfg
source $dir_bashrc/fs.cfg
source $dir_bashrc/general.cfg
source $dir_bashrc/grep.cfg
source $dir_bashrc/history.cfg
source $dir_bashrc/menu.cfg

source $dir_bashrc/rm.cfg
source $dir_bashrc/prompt.cfg #share history between all shells

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

}

export -f scaffold
export -f update_file
export -f update_dir
#source ../do-for-others-first/src/rc/packagerc.fun
color()(set -o pipefail;"$@" 2>&1>&3|sed $'s,.*,\e[31m&\e[m,'>&2)3>&1
sed_dry_run(){
    find ./ -type f | xargs sed -i 's/string1/string2/g'
        
    while IFS= read -r -d $'' file; do
          sed -i 's/string1/string2/g' "$file"
      done < <(find ./ -type f -print0)
}
export -f sed_dry_run
