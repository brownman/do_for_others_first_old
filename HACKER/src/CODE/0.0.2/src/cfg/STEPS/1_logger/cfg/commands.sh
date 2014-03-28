#!/bin/bash

file_example=proxy0.cfg
file=${1:-$file_example}
cat $file | grep '()'
grep -r run_list .
