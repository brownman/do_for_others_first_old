dir_self=`dirname $0`



dir="$dir_self/PROJECT"


echo "do u want to lock dir: $dir ?"
read answer


if [ $answer = y ];then
    cmd="chmod u-w $dir"
else
    cmd="chmod u+w $dir"
fi


echo press Enter to confirm
echo "[cmd] $cmd"


read
eval "$cmd"

