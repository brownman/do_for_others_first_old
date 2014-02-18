#!/bin/bash
#Zenity code: http://c2asr.altervista.org/  (Mattia Castiglione)
#FFmpeg code: http://www.edmondweblog.com/index.php/2011/02/02/screencast-perfetto-di-una-singola-finestra-con-ffmpeg (Edmond)

while true; do

action=$(zenity --list --width 400 --height 280 --title "Zenity Desktop Recorder" --text "<b>Caution</b>\\n<b>1.</b> Click on the desktop to record the entire screen \\n<b>2.</b> Click on the title of the window to record only one window\\nChoose action:" --radiolist --column="Pick" --column="Action" FALSE "Record Video + Audio"   TRUE "Record Video" FALSE "Info"  FALSE "Exit manager");
	

case "$action" in

  "Record Video + Audio")

	INFO=$(xwininfo -frame)

	WIN_GEO=$(echo $INFO | grep -oEe 'geometry [0-9]+x[0-9]+' | grep -oEe '[0-9]+x[0-9]+')
	WIN_XY=$(echo $INFO | grep -oEe 'Corners: \+[0-9]+\+[0-9]+' | grep -oEe '[0-9]+\+[0-9]+' | sed -e 's/\+/,/' )
	
	bi=$(zenity --scale --text "Choose video quality" --min-value=1 --max-value=5 --value=1 --step 2);
	bitrate=$bi*1000000

	zenity --info --title="Stop Rec"  --text "Click on panel notify to stop record"
	sleep 2

	ffmpeg -f alsa -ac 2 -i hw:0,0 -f x11grab -r 30 -b $bitrate -s $WIN_GEO -i :0.0+$WIN_XY -acodec pcm_s16le screencast.avi & zenity --notification --window-icon="" --text="Stop Zenity Desktop Recorder" 
	pkill ffmpeg

     ;;

	"Record Video")

	INFO=$(xwininfo -frame)

	WIN_GEO=$(echo $INFO | grep -oEe 'geometry [0-9]+x[0-9]+' | grep -oEe '[0-9]+x[0-9]+')
	WIN_XY=$(echo $INFO | grep -oEe 'Corners: \+[0-9]+\+[0-9]+' | grep -oEe '[0-9]+\+[0-9]+' | sed -e 's/\+/,/' )
	
	bi=$(zenity --scale --text "Choose video quality" --min-value=1 --max-value=5 --value=1 --step 2);
	bitrate=$bi*1000000

	zenity --info --title="Stop Zenity Desktop Recorder"  --text "Click on panel notify to stop record"
	sleep 2

	ffmpeg -f x11grab -r 30 -b $bitrate -s $WIN_GEO -i :0.0+$WIN_XY screencast.avi & zenity --notification --window-icon="" --text="Stop Zenity Desktop Recorder" 
	pkill ffmpeg

     ;;

	"Info") 
	export DEMO_TXT="<b>Zenity Desktop Recorder</b>\\nThis script is a simple Desktop Recorder\\n\\n<b>Authors:</b>\\nZenity code: <a href = \"http://c2asr.altervista.org/\">Mattia Castiglione</a>\\nFFmpeg code: <a href = \"http://www.edmondweblog.com/index.php/2011/02/02/screencast-perfetto-di-una-singola-finestra-con-ffmpeg/\">Edmond</a>"
		zenity --info --title="Zenity Desktop Recorder"  --text "$DEMO_TXT"
	;;

	"Exit Manager")
		action=*
	;;

	*)

	break
	;;
	
esac
done
