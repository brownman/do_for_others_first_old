#!/bin/bash
args=${1:-5}

echo "sleep.sh got: $args"
run(){
    sleep $args
}
run

