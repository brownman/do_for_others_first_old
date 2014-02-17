#export SUCCESS=1
#export FAILURE=0
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
scaffold(){
    str_bash="#!/bin/bash"
        echo 'scaffolding..'
###################### cfg / global funcs (2)
        touch vars.cfg
        touch helpers.cfg
###################### scripts:  (3)
# wrapper: play all tools
# test:    self test/present/check/validate/help/info
# script:  the simplest/cleanest snippet of code
#####################
#
#
#

        file=.gitignore



        if [ ! -f "$file" ];then
            touch $file
                echo '.old' >> .gitignore

                echo 'added: .gitignore: .old'
        else
            echo "file already exist:  $file"
                fi



                func1=check_X
                file=test.sh

                if [ ! -f $file ];then
                    touch $file
                        echo -e "$str_bash\n\n\n\n${func1}(){\n \
                        echo '${func1}()'\n}\n\n\n${func1}" \
                        >> $file
                        else
                        echo  "file already Exist:  $file"
                        fi

                        func1=steps
                        file=wrapper.sh

                        if [ ! -f $file ];then
                        touch $file
                        echo -e "$str_bash -e\nset -o nounset\n\n\n\n${func1}(){\n \
                            echo '${func1}()'\n}\n\n\n${func1}" \
                            >> $file
                            else
                            echo  "file already Exist:  $file"
                            fi

                            func1=snippet_X
                            file=script.sh

                            if [ ! -f $file ];then
                            touch $file
                            echo -e "$str_bash\n\n\n\n${func1}(){\n \
                                echo '${func1}()'\n}\n\n\n${func1}" \
                                >> $file
                                else
                                echo  "file already Exist:  $file"
                                fi

                                echo 'export -f func' >> helpers.cfg
                                echo 'export VAR=""' >> vars.cfg

                                chmod u+x script.sh
                                chmod u+x wrapper.sh
                                chmod u+x test.sh





                                dir=PRESENTATION
                                if [ ! -d "$dir" ];then
                                mkdir $dir
                                touch $dir/demo1.gif
                                else
                                echo "dir  already exist:  $dir"
                                fi

                                file=README.md
                                if [ ! -f $file ];then
                                touch $file
                                name0=`pwd`
                                name=`basename $name0`
                                echo -e "$name\n====\n![demo1](./PRESENTATION/demo1.gif)" >> $file
                                else
                                echo  "file already Exist:  $file"
                                fi
echo
                                echo "HINT: test it with:     grep -rn '' ."
                                }
export -f scaffold

