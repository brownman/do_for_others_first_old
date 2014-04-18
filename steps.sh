echo "dir root: [ $dir_root ] "
echo "[ runner ]  $0"
sleep 3
if [ "$0" = bash ];then
cmd="source $dir_root/SOURCE/breath.cfg"

eval "$cmd" 
#eval "$cmd" 1>/dev/null
#every 2 "$cmd"
else
cmd="bash -c $dir_root/SETUP/breath.cfg"
eval "$cmd"
fi
