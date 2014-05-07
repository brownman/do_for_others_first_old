pv1(){
echo "$@" | pv -qL 10
}
update_clipboard(){
echo "$@" | xsel --clipboard
}
proxy(){
    args=( $@ )
    cmd="${args[@]}"
    echo ----------
    echo "[cmd] $cmd"
    eval "$cmd"
    echo --------
}
routes(){
    pv1 show default gw
sudo netstat -rn

}
restart(){
#proxy sudo /etc/init.d/networking restart
#pv1 Yes, as the warning say, restart is deprecated: 
#pv1 don\'t worry, the service will restart correctly.
#"ifdown eth1:1; ifdown eth1; ifup eth1"
proxy "sudo ifdown eth0 && sudo ifup eth0"

}
help(){
echo  To set the static IP address
echo  vi /etc/networking/interfaces
echo vi /etc/resolv.conf
}
step(){

local step=$1
echo
echo "[step] $step"
eval "$step"
}
steps(){
clear
#echo options: help / restart
#read answer
#eval "$answer"
step help
step restart
step routes
proxy update_clipboard sudo vi /etc/network/interfaces

}

cmd=${1:-steps}
proxy "$cmd"



:<< COMMENT
# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
auto eth0
iface eth0 inet static
#address as set manualy on my router under dhcp-static-ip:
address 192.168.0.7
gateway 192.168.0.1
netmask 255.255.255.0
network 192.168.0.0
broadcast 192.168.0.255
==========================================

kristian@proxy:~$ netstat -rn
Kernel IP routing table
Destination     Gateway           Genmask         Flags   MSS Window  irtt Iface
0.0.0.0         192.168.XXX.ZZZ   0.0.0.0         UG        0 0          0 eth0
192.168.XXX.0   0.0.0.0           255.255.255.0   U         0 0          0 eth0
192.168.AAA.0   0.0.0.0           255.255.255.0   U         0 0          0 eth1

COMMENT





