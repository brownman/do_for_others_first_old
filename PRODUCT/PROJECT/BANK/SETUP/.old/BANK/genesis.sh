#set -x
echo try to control + c
sleep 4
file_list=$dir_root/genesis.yaml
while read line;do
proxy pv "$line"
sleep 1
done<$file_list

