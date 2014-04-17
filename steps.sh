
echo "[ runner ]  $0"
sleep 3
if [ $0 = bash ];then
cmd="source $dir_root/SOURCE/load_project.cfg"
eval "$cmd" 1>/dev/null
#every 2 "$cmd"
else
cmd="bash -c $dir_root/SETUP/list.sh"
eval "$cmd"
fi
