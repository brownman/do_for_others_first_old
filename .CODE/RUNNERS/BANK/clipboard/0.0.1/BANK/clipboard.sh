#depend_package: xsel
clear
steps(){
#info: open website for bash - syntax check
#depend_package: exo-open
	url="http://www.shellcheck.net"
		exo-open "$url"
}

if [ $0 = $BASH_SOURCE ];then
if [ $# -gt 0 ];then
file_target=$1
if [ -f "$file_target" ];then
cat $file_target | xsel --clipboard
steps
fi
else
echo '[error] supply a shell source file'
fi


fi
