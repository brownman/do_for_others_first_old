#!/bin/bash
pushd `dirname $0`
clear
str_msg_start='start'
str_msg_end='end'
#dir=`dirname $0`
ptrn=`echo "export dir_root=$PWD;source $PWD/setup.cfg"`
echo "searching for pattern: $ptrn"
cmd="grep \"$ptrn\" ~/.bashrc"


print_color () { 
        echo -e "\x1B[01;$1m[*]\x1B[0m $2 "
}


run(){
print_color 32 "$str_msg_start"



result=$(eval "$cmd")
echo  "result: $result"
if [ "$result" = '' ];then

   print_color 31 "your ~/.bashrc is missing a line which load this project"
   sleep 1
   echo "LINE: $ptrn"
   sleep 1
   echo "adding this line to your: ~/.bashrc"
   sleep 2
   echo "$ptrn" >> ~/.bashrc
   sleep 1 
   print_color 32 "DONE!"
else

    echo "PROJECT ALREADY SUCCESSFULY INSTALLED !"
    #echo "your ~/.bashrc file contains a line that loads this project's setup"
    grep setup.cfg ~/.bashrc --color=auto
    echo "lets load it now!"
    sleep 5
    source ~/.bashrc
fi

print_color 32 "$str_msg_end"
}
run
popd

