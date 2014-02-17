#!/bin/bash
set -o nounset
dir=`dirname $0`
file_menu=$dir/options.txt

source $dir/helpers.cfg
source $dir/vars.cfg

steps(){
   # xfce4-settings-manager
   if [ "$GUI" = true ];then
       res=`menu_gui $file_menu`
   else
       res=`menu_cli $file_menu`
   fi
   echo "res: $res"
   eval "$res"

}



steps
