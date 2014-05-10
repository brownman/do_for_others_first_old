user(){
pv1 is cron running ?
ls /tmp/suspend.sh
pv1 does list1 sync between the 2 comps?
ps | grep list1.sh
}

xfce(){
pv1 which wallpaper set recently?
pv1 which keys are configured?
}

crontab1(){
pv1 who crontab is configured?
#crontab -l
#sudo crontab -l
}
step(){
funcname=$1
( type $funcname  )
echo Run it?
echo press a key to continue!
#read
( eval $funcname )

}


steps(){
step user
step xfce
step crontab1
}
steps
