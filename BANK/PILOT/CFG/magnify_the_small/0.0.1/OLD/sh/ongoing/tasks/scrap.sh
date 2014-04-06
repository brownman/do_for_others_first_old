#!/bin/bash

# about file:
#  
#
#



. $TIMERTXT_CFG_FILE
quote(){
echo "curl http://en.wikiquote.org/wiki/Russian_proverbs | head -$1 | tail -$2"
curl "http://en.wikiquote.org/wiki/Russian_proverbs" | head -${1} | tail -${2}

}
google(){ 
    Q="$@"; GOOG_URL='https://www.google.de/search?tbs=li:1&q='; AGENT="Mozilla/4.0"; stream=$(curl -A "$AGENT" -skLm 10 "${GOOG_URL}${Q//\ /+}" | grep -oP '\/url\?q=.+?&amp' | sed 's|/url?q=||; s|&amp||'); echo -e "${stream//\%/\x}";
}
guitar(){
for n in E2 A2 D3 G3 B3 E4;do play -n synth 4 pluck $n repeat 2;done
}
commandFU(){
local format="plaintext"
local command_set="browse/sort-by-votes"
#browse/sort-by-votes - All commands sorted by votes
#tagged/163/grep - Commands tagged with 'grep', sorted by date (the default sort order)
#matching/ssh/c3No -
url="http://www.commandlinefu.com/commands/$command_set/$format/"
lynx -dump $url
#curl $url
}

echo "scrap.sh got: 1: $1 | 2: $2"
if [ "$1" = '' ];then
    red "try: google | commandFU" 
else
    green "eval $1 $2"
    eval "$1 $2"
fi


echo 'save this scrap ?'
read answer
if [ "$answer" = y ];then 
    update_file $scrap_txt "$1 $2"
fi

yellow "scrap.txt:"
cat $scrap_txt
