clear
#set -x
set -e 
set -o nounset

#!/usr/bin/env bash

# IMPORTANT: to be used as a script for a Thunar custom action
# it will need modification if used for other purposes

# path is %f given in Thunar's context menu
path="/tmp"
recognize_current(){
workspace="$(xdotool get_desktop)"
}
ensure_multiple(){
# check not in single workspace mode
xfconf-query -c xfce4-desktop -p /backdrop/single-workspace-mode -s false
}
match_pair(){
# command with workspace and path variables
xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/workspace"${workspace}"/last-image -s "${path}"
}
change_pic(){
xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/image-path -s $file_image
echo
}
change_many_pics(){
    while :; do xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/image-path -s "$(find <image-directory> -type f -iregex '.*\.\(bmp\|gif\|jpg\|png\)$' | sort -R | head -1)"; sleep 30m; done
echo
}


step(){
echo "[  step  ] $1"
eval $1
}

steps(){
step recognize_current
#step ensure_multiple
step match_pair
}


steps
