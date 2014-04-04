#!/bin/bash -e
set -o nounset
dansguardian(){
	grep -R sex /etc/dansguardian/lists/phraselists/pornography/ > ~/sex1.txt
		cat sex1.txt | cut -d':' -f2 > ~/sex2.txt
		cat ~/sex2.txt | sed s/�//g > ~/sex3.txt
		cat ~/sex3.txt | sed 's/[<>]//g' > ~/sex4.txt
}
present(){
#depend_package: pv
	local str="$@"
		echo "$str" | pv -qL 10
}
change_sample_rate(){
#depend_package: sox
local file_in=$1
local file_out=$2
local rate=16000
#44100
	present Change the sample rate with sox
local cmd="sox $file_in -r $rate $file_out resample -b 8"
echo "$cmd"
#eval "$cmd"

}
voice_recognition(){
#depend_package: flite, flac, wget 
#use: change_sample_rate
	present voice recognition
		str_say="hello world"
		file_wav=/tmp/file_wav.wav
		file_wav_new=/tmp/file_wav_new.wav
		file_flac=/tmp/file_flac.flac

		flite -t $str_say -o $file_wav
change_sample_rate "$file_wav" "$file_wav_new"
		flac --fast -f $file_wav_new -o $file_flac
		wget -q -U "Mozilla/5.0" --post-file $file_flac --header="Content-Type: audio/x-flac; rate=16000" -O - "http://www.google.com/speech-api/v1/recognize?lang=en-us&client=chromium"

}



voice_recognition
set +o nounset
