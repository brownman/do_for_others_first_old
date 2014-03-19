#!/bin/bash
pushd `basename $0`>/dev/null
file=$1
ls -l $file
sudo chown root $file
sudo chgrp root $file
ls -l $file | grep root --color=auto
popd>/dev/null
