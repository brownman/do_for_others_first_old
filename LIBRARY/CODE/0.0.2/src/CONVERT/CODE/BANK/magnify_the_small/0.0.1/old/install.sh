#packaging for debian
apt_get(){
flite
xcowsay
lib-notify
wget
sqlite3
gxmessage
}
gem(){
gem install watchr
}
pip(){
    pip install shyaml
#https://github.com/0k/shyaml
}
shortcuts(){
echo

}
cron(){
crontab crontab.txt

}

########### INSTALL: create ########
#TMP1=/tmp
TMP1=''


#cache
export dir_html=$TMP1/TORRENTS/html
export dir_txt=$TMP1/TORRENTS/txt
export dir_mp3=$TMP1/TORRENTS/mp3
export DIR_LEARN_LANGS=$TMP1/TORRENTS/AUDIO/LANGS
###
#extract to DIR_LEARN_LANGS: http://www.50languages.com/book2/EN/ENRU/ENRU-all.zip
###
mkdir -p $dir_html $dir_txt $dir_mp3 $DIR_LEARN_LANGS


