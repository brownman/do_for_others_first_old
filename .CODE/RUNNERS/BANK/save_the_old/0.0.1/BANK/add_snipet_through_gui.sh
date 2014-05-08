#info: add a snippet through a gui helper
reset
history1(){
grep "$1" -lr --exclude-dir='.git' "$dir_root" | grep .cfg
}
test1(){
#info: translate
#pending: add content
echo
}

typy1(){
    type  "$1"

}

steps(){
    echo 'which keyword will help you save the script ?'
    read input
echo "input: $input"
echo "-=-=-=-=-="
echo type1 "$input"
echo history1 "$input"
echo test1 "$input"
}





steps
