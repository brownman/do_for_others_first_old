#!/bin/bash
str=`date | cut -d' ' -f4`
notify-send "suspend on?" "$str/$1"
