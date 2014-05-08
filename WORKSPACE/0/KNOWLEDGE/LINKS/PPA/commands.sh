
cat <<COMMENT
deb http://ppa.launchpad.net/zanchey/asciinema/ubuntu precise main 
deb-src http://ppa.launchpad.net/zanchey/asciinema/ubuntu precise main 
COMMENT



echo sudo vi /etc/apt/sources.list
echo sudo apt-get update
echo sudo apt-get install asciinema
