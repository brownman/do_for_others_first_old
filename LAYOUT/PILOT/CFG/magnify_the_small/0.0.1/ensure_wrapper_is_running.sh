let 'counter_death=0'
set -o nounset
func(){
while [ 1 ];do
    cowsay "new life: $counter_death"
#local   cmd="./wrapper.sh bin/1_tasker/tasker.sh"

cmd="$sh_wrapper ./wrapper.sh"
   echo "$cmd"
   (   eval "$cmd" 2>/tmp/err )

    cat /tmp/proxy | tail -5

    cat /tmp/err
    notify-send "error on tasker"
    sleep 2

#    gxmessage -title "died young: $counter_death" -file /tmp/err -timeout 5

    let 'counter_death+=1'
    breaking
done
}
func

