#./wrapper.sh singles/single.sh awake $1

reset
str=bin/0_sos/sos.sh
dir_root=`dirname $0`
cmd1="$dir_root/chase_the_problem.sh $str"
cmd2="$dir_root/loop_fallback_for_easy_life.sh $str"
proxy "$cmd1"

proxy "$cmd2"
