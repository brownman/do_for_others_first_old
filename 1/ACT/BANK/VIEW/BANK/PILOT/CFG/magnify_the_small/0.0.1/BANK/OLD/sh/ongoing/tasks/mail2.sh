#!/bin/bash

# about file:
#  
#
#



. $TIMERTXT_CFG_FILE
str="$USER1:$PASS1"

#echo2 "$str"
curl  --ssl-reqd -u "$str" --silent "https://mail.google.com/mail/feed/atom" | tr -d '\n' | awk -F '<entry>' '{for (i=2; i<=NF; i++) {print $i}}' | sed -n "s/<title>\(.*\)<\/title.*name>\(.*\)<\/name>.*/\2 - \1/p"
curl  --ssl-reqd -u "$str" --silent "https://mail.google.com/mail/feed/atom" | awk 'BEGIN{FS="\n";RS="(</entry>\n)?<entry>"}NR!=1{print "\033[1;31m"$9"\033[0;32m ("$10")\033[0m:\t\033[1;33m"$2"\033[0m"}' | sed -e 's,<[^>]*>,,g' | column -t -s $'\t' 
curl  --ssl-reqd -u "$str" --silent "https://mail.google.com/mail/feed/atom" | perl -MHTML::Entities -ne 'print "\t" if /<name>/; print decode_entities($2)."\n" if /<(title|name|issued)>(.*)<\/\1>/;'
#curl -n --ssl-reqd
