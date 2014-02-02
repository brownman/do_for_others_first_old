
#!/bin/bash

func3(){
  echo "1: $1"
  echo "2: $2"
    echo "3: $3"

  }

func2(){
 first=$1
  shift
  args=("$@")
  echo "self: ${FUNCNAME[0]} : run: $first , args: ${args[@]}"
  "$first" "${args[@]}"
  }

func1(){
  first=$1
  shift
  args=("$@")
  echo "self: ${FUNCNAME[0]} : run: $first , args: ${args[@]}"
  "$first" "${args[@]}"
}

func1 func2 func3 'a a' "b b" "d d"
echo "Hello World!" 
