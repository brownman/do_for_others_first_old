#!/bin/bash
#url: http://www.thegeekstuff.com/2009/09/unix-sed-tutorial-printing-file-lines-using-address-and-patterns/
#cat eof: https://github.com/0k/shyaml
dir_self="dirname "
file_text=$dir_self/text
step1(){
    cat text
}
step2(){
# sed -n ‘N’p filename

pv For example, 3p prints third line of input file thegeekstuff.txt as shown below.
  pv expect  3. Hardware
local cmd="sed -n '3'p $file_text"
eval "$cmd"

}

steps(){
#    step1
#    step0
step1
step2
}


steps
