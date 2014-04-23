#!/bin/bash
#nvm use 0.8
#tracex ""
echo "commands.sh"
. ~/.profile
path1=/TORRENTS/JAVASCRIPT/casperjs
lang="$1"
str="$2"
str_ws=$(echo "$str"|sed 's/ /_/g');
script_js="$3"
trace "commands.sh got: lang: $1 || str: $2" 


file_html=$(  echo $dir_html/${str_ws}_${lang}.html )
#file_html=/tmp/test1.html


trace "html file: $file_html"
$path1/bin/casperjs $script_js --target="$lang" "$str" > $file_html

#cat /tmp/test1.html | head -1

sleep 5
#(exo-open $file_html  &) 
google-chrome $file_html &
#cp $file_html "$file_html1"
sleep 25

#./bin/casperjs ./samples/translate.coffee --target=ru 'small' | grep noun
#grep fetchText . -r
#./bin/casperjs ./samples/translate.js --target=ru 'nice' > test1.html
#grep timeout . -r
