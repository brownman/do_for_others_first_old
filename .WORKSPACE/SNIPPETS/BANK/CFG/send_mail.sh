#!/bin/bash
 
# http://www.panticz.de/Send-email-from-console
 
INPUT=./adr_uniq.txt
CONTENT=./nl_de.html
SUBJECT="YOUR_SUBJECT"
LOG=./nl_de_$(date -I).log
 
# send 
for i in $(cat $INPUT); do
   mail -a 'Content-type: text/html;' -s "$SUBJECT" "$i" < $CONTENT
   echo "$i - $?" | tee -a $LOG
done
