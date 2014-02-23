#!/bin/bash -e
set -o nounset
path=`pwd`
use(){

echo "use()"
line=$1


echo "line: $line"
local dir0=`echo "$line" | cut -d'.' -f1`
local dir1=`echo "$line" | cut -d'.' -f2`
local file1=`echo "$line" | cut -d'.' -f3`

path_full="$path/$dir0/$dir1/$file1.cfg"
#export $path_full
cmd="source $path_full"

echo "$cmd"
eval "$cmd"
}

use bashrc.history.save
save
#bashrc.proxy.proxy
#bashrc.sleep.sleep
#bashrc.cat
#bashrc.eval.detach
#bashrc.eval.commander
#bashrc.eval.confirm
#bashrc.fs.rm
#bashrc.grep.finder
#bashrc.grep.replace

#bashrc.layout.tree
#bashrc.ln.desktop
#bashrc.menu
#bashrc.prompt.history_sync
#bashrc.proxy.proxy
#bashrc.proxy.proxy1
#
#packagerc.array.str_to_arr
#packagerc.color.colors
#packagerc.color.printing
#packagerc.parse.parse
#packagerc.regular.regex.cfg
#packagerc.self.self
