#file=${1:-/home/dao04/JAIL/TREE/BANK/CFG/REGULAR/.old/PRE-LIB/SPLIT_ME/helper.cfg}
dir_self=`dirname $BASH_SOURCE`

steps(){
local file=$1
source $file
funcs=$( cat $file | grep "(){" | grep -v "#" | sed 's/(){//g' )
for func in $funcs;do
#    source $func
( echo "$func" >> $dir_self/funcs.txt  ;    type $func | tail -n +2  > /tmp/${func}.cfg )
#1>>$dir_self/funcs.txt )
done
echo '[RESULTS] '
[ -s $dir_self/funcs.txt ] && { cat -n $dir_self/funcs.txt; } || { echo no results found; }
}


if [ $# -gt 0 ];then

file=$1
   if [ -f $file ];then
       echo $file > $dir_self/.history
       [ -f $dir_self/funcs.txt ] && { rm $dir_self/funcs.txt; }
       steps $file
   else
       echo invalid file
   fi
else
    echo supply a file with functions - and I will split them for you
    cat $dir_self/.history 2>/dev/null
fi
