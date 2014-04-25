every 2 "set -x"

every 2 "set -u"
every 2 "set -e"

step1(){
local file=$dir_root/0/first.cfg  
echo Running In A sub-shell - saving time
source $file  ; echo "res: $?" ; echo now source yourself; 

}
step2(){

update_clipboard "source $file";  
}

sub_shell(){
echo "$( step1 )"
}



steps(){
#    dir_self=`dirname $0`
    sub_shell
}
steps
