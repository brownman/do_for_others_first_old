#!/bin/bash
user=''

if [ "$(id -u)" != "0" ]; then
    user='user'
else
    user='root'
fi


time1=`date | cut -d' ' -f4 | sed 's/:/_/g'`
file=/home/dao04/Desktop/${time1}_${user}.txt
touch $file
crontab -l > $file 

flite -t "$user"
notify-send "$user"
xcowsay "$user"
#gxmessage -file $dir_workspace/cron/crontab.user.txt -title "$user"


#!/bin/bash
act=$1
shift
args="$@"

path=`dirname $0`
dir_sh=$path/act

run(){
$dir_sh/$act.sh "$args"

}
run
#!/bin/bash

str1="$1"


info(){
/usr/bin/env -i $(cat /tmp/cron-env)
}
update_env(){
    #source /etc/profile
    source /home/$USER/.bashrc
}
run(){


    flite "restart $str1"
    if [ "$str1" = '' ];then
        flite 'no arguments'
    else
        info
       #update_env 
        action 
    fi

}
action(){
local file=/home/$USER/magnify_the_small/genius.sh
local cmd="$file one_cron \"$str1\""
local result=$( eval "$cmd" )
echo "$result"
}

run
#flite "finish $str1"
#!/bin/bash -e



args="$@"
path=`dirname $0`
echo "restart $args" | flite &
notify-send "restart $args" 



source $path/cfg/struct.cfg

load_cron_env(){
file_env=$dir_cfg/env_dump.cfg
source $file_env
}
run(){
load_cron_env
cmd="$dir_project/run.sh $args"
eval "$cmd" 2>$dir_txt/error.txt
}
run

#!/bin/bash

flite croning &
notify-send alive
xcowsay alive

