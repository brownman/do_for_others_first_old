#!/bin/bash
# about file:
# plugin:
# update .txt files faser


#. $TIMERTXT_CFG_FILE

echo 'help: use:'
blue 'txt_file |  title | content '
blue 'txt_file |  url | content'
file="$1"
title="$2"
content="$3"
filename="${file}.txt"
#touch $DYNAMIC_DIR/${filename}
#echo "$DYNAMIC_DIR/$filename|$title|$content"

echo "$title|$content" >> $DYNAMIC_DIR/${filename}
cat $DYNAMIC_DIR/${filename}


