#!/bin/bash
pushd `dirname $0`>/dev/null
$lister_sh

cmd="cd $PWD"
echo "$cmd" | /usr/bin/xsel --clipboard
echo "vi"


echo 'updating the clipboard'
popd>/dev/null
