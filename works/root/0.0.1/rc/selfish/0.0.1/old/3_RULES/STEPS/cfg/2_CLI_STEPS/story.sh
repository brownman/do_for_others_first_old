#!/bin/bash -e
set -o nounset
use bashrc.translation.translation
lang=ru

run(){
echo "what do you want to do now ?"

while [ 1 ];do
    read answer
    translate "$answer"
done

}


run
