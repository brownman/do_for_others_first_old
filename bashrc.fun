dir_lib=$dir_root/bashrc


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


alias single1="$dir_root/breath.sh project/bin/single.sh"
export BASHRC_LOADED=true
echo "LOADING: bashrc.fun"

exist(){
cmd="$1"
type $cmd >/dev/null 2>&1 || { echo -e >&2 "false" ;}
}
export -f exist 
