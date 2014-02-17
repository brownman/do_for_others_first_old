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
touch wrapper.sh
# test:    self test/present/check/validate/help/info
touch test.sh
# script:  the simplest/cleanest snippet of code
touch script.sh
#####################


func1=check_X
file=test.sh
echo -e "$str_bash\n\n\n\n${func1}(){\n \
     echo '${func1}()'\n}\n\n\n${func1}" \
     >> $file

func1=steps
file=wrapper.sh
echo -e "$str_bash -e\nset -o nounset\n\n\n\n${func1}(){\n \
     echo '${func1}()'\n}\n\n\n${func1}" \
     >> $file

func1=snippet_X
file=script.sh
echo -e "$str_bash\n\n\n\n${func1}(){\n \
     echo '${func1}()'\n}\n\n\n${func1}" \
     >> $file

echo 'export -f func' >> helpers.cfg
echo 'export VAR=""' >> vars.cfg

chmod u+x script.sh
chmod u+x wrapper.sh
chmod u+x test.sh


grep -rn '' .



}
export -f scaffold

