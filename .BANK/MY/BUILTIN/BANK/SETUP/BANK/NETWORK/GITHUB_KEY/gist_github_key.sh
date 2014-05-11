#!/bin/bash
#depend: xclip pv1 
proxy(){
    args=( $@ )
    cmd="${args[@]}"
    echo "[cmd] $cmd"
    eval "$cmd"
}
set -e
set -o nounset
#set -x
clear
pv1(){
echo "$@" | pv -qL 10
#"$(10+(-2 + RANDOM%5))"
}
pv1 add github ssh public key
pv1 Lists the files in your .ssh directory

proxy cd ~/.ssh
proxy ls -al
proxy ssh-keygen -t rsa -C "brownman556@gmail.com"

pv1 Creates a new ssh key, using the provided email as a label

cat <<COMMENT
EXPECTED RESULTS: 
example:
Your identification has been saved in /home/you/.ssh/id_rsa.
# Your public key has been saved in /home/you/.ssh/id_rsa.pub.
# The key fingerprint is:
# 01:0f:f4:3b:ca:85:d6:17:a1:7d:f0:68:9d:f0:a2:db your_email@example.com
COMMENT

pv1 add the key to the agent



proxy ssh-add ~/.ssh/id_rsa
pv1 Copies the contents of the id_rsa.pub file to your clipboard
#proxy xclip -sel clip < ~/.ssh/id_rsa.pub

proxy xsel --clipboard < ~/.ssh/id_rsa.pub 
proxy exo-open https://github.com/settings/admin
pv1 finally validate the connection
proxy ssh -T git@github.com




cat <<COMMENT1
EXPECTED RESULTS: 
example:

[cmd] ssh -T git@github.com
The authenticity of host 'github.com (192.30.252.131)' can't be established.
RSA key fingerprint is XXXX:a6:48.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'github.com,192.30.252.131' (RSA) to the list of known hosts.
Hi brownman! You've successfully authenticated, but GitHub does not provide shell access.
COMMENT1
