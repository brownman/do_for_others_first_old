#!/bin/bash -e
xfconf-query -c xfce4-keyboard-shortcuts -p "/commands/custom/<Alt>F3" -t string -s "$PWD/wrapper.sh" --create

