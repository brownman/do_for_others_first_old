str=`ls -l library.cfg | cut -d'>' -f2`
echo "$str" | xsel --clipboard
