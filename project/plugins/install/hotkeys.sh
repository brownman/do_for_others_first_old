#!/bin/bash
args="$@"


notify-send "$@"
gui(){
xfce4-settings-editor
}

query(){

}

locate(){
locate xfce4-keyboard-shortcuts.xml
}
