#!/bin/bash -e

str_wish="record your doings - prepare a package"

steps(){
echo "Step: 1"
ehco "imagine first"
$dir_project/breath.sh imagine_first

echo "Step: 2"
echo "$str_wish"

echo "Step: 3"
echo "life recorder:"
$dir_project/breath.sh screencast

}


steps

