#!/bin/bash
if [ $# -eq 1 ];then
file=$1
markdown $file | htmldoc --cont --headfootsize 8.0 --linkcolor blue --linkstyle plain --format pdf14 - > $file.pdf
else
    echo 'supply a markdown file'
fi
