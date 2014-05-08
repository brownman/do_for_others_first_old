clear
proxy(){
    local args=( $@ )
    local cmd="${args[@]}"
    local runner=${args[0]}
    type $runner &>/dev/null
    res=$?
    [ $res -eq 1  ] &&  { echo "[cmd] not found: " "$runner";exit 1; } || { eval "$cmd";}

}
step(){
eval "$1"
}
set_env(){
remote_ip="192.168.1.3"
nmap_opts=( -sV -Pn )
#opt1: -sV - service fingerprint
#opt2: -n  - list of open ports

}
all_subnet(){

    #http://www.commandlinefu.com/commands/matching/alive/YWxpdmU=/sort-by-votes
}
ensure_alive(){
until ping $remote_ip;do true;done
}

check_services(){
#reason: scan single i.p
proxy "nmap ${nmap_opts[@]} $remote_ip"
}
steps(){
#set target ip + arguments for nmap/else
set_env
step ensure_alive
step check_services

}


steps
