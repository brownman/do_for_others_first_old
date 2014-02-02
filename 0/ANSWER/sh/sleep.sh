#!/bin/bash -e
args=${1:-5}

echo "sleep.sh got: $args"
run(){
sleep1 $args
}
run
