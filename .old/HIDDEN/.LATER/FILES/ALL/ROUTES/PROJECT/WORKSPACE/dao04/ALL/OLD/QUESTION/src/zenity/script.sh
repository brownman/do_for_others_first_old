zenity --list --width 500 --height 500 --column 'radio' --column 'url' --print-column 2 $(curl -s http://www.di.fm/ | awk -F '"' '/href="http:.*\.pls.*96k/ {print $2}' | sort | awk -F '/|\.' '{print $(NF-1) " " $0}') | xargs mplayer
