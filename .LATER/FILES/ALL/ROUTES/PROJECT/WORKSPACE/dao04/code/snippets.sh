 find -iname '*mp3' -exec mid3iconv {} \;
Fix "broken" ID3 tags in the current directory and subdirectories
Some MP3s come with tags that don't work with all players. Also, some good tag editors like, EasyTAG output tags that don't work with all players. For example, EasyTAG saves the genre as a numeric field, which is not used correctly in Sansa MP3 players.
This command corrects the ID3 tags in MP3 files using mid3iconv, which comes with mutagen. To install Mutagen on Fedora use "yum install python-mutagen"
http://www.micahcarrick.com/sansa-view-ubuntu.html


http://askubuntu.com/questions/66096/how-to-set-up-xfce4-xkb-plugin-to-remember-settings-over-reboots
x


KjlkjKLjkjC
