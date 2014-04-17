file_name=logger.db

#file_absolute=$(echo "$file_name-$(date +%m_%d_%Y_%H_%M).db")
dir1=$DATA_DIR/sql
#/tmp/1.txt
#file_from=/tmp/1.txt



gui1(){
nautilus sftp://$host:2222
}

ssh01(){

host=46.210.221.38
ssh -p $port $host
}

scp1(){
COMMANDER=true
local file_to="$host:/sdcard/$file_name"
local cmd="scp  -P 2222 $dir1/$file_name $file_to"

commander "$cmd"
#local str=$(ls -l $file_to )
#gxmessage $GXMESSAGET "$str" -title 'file exist ?'
}
menu(){
echo 'choose the operation'
}

scp1
#ssh01
gui1
