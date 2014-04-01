#scrap google for new deals
#
#http://www.commandlinefu.com/commands/matching/google/Z29vZ2xl/sort-by-votes
step1(){

    #assert_equal_str "$1"
    echo "great: got  $1"
}

google1() {
    Q="$@"; GOOG_URL='https://www.google.de/search?tbs=li:1&q='; 
    AGENT="Mozilla/4.0"; stream=$(curl -A "$AGENT" -skLm 10 "${GOOG_URL}${Q//\ /+}" \
        | grep -oP '\/url\?q=.+?&amp' | sed 's|/url?q=||; s|&amp||');
    echo -e "${stream//\%/\x}"; 
}

define(){ local y="$@";curl -sA"Opera" "http://www.google.com/search?q=define:${y// /+}"|grep -Po '(?<=<li>)[^<]+'|nl|perl -MHTML::Entities -pe 'decode_entities($_)' 2>/dev/null;}

find_website_title(){
    local result=''
    local cmd="$1"

    export COMMANDER=true
    result=$(commander  "$cmd")
    echo "result: $result"
}


query(){
    local res=''
    local str=''
    local input="$1"
    while :;do
        input=$(gxmessage -entrytext "step1 $input" "$res" -title 'new query')
        if [ "$input" ];then
            res=$(find_website_title "$input")
        else
            break
        fi


        #assert_equal_str "$res"
        sleep1 5
    done
    echo "query $1"


}
query "$1"
