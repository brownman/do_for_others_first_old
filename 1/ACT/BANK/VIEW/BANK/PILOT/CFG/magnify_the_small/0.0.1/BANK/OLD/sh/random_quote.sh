#!/bin/bash
# about file:
# plugin:       random_quote
# scrap a web page using basic tools
#http://www.commandlinefu.com/commands/matching/random-quote/cmFuZG9tIHF1b3Rl/sort-by-votes
#http://www.quotesdaddy.com/quote/990706/niccolo-machiavelli/men-shrink-less-from-offending-one-who-inspires-love
step1(){
    cmd=$(curl -s http://bash.org/?random1|grep -oE "<p class=\"quote\">.*</p>.*</p>"|grep -oE "<p class=\"qt.*?</p>"|sed -e 's/<\/p>/\n/g' -e 's/<p class=\"qt\">//g' -e 's/<p class=\"qt\">//g'|perl -ne 'use HTML::Entities;print decode_entities($_),"\n"'|head -1)

    result=$(eval "$cmd")
    echo "$result"
}
$@
