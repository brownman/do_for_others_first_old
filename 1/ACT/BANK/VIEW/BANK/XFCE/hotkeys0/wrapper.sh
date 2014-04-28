#!/bin/bash -e
set -o nounset


pushd `dirname $0` > /dev/null

dir=`pwd`
dir_menu=$dir/menu
file_menu=$dir_menu/options.txt

source $dir/helpers.cfg
source $dir/vars.cfg

steps(){
   # xfce4-settings-manager
#   if [ "$GUI" = true ];then

       desc=`menu_gui $file_menu | cut -d'|' -f1`
       res=`menu_gui $file_menu | cut -d'|' -f2`
#   else
#       res=`menu_cli $file_menu`
#   fi
   echo "res: $res"
   notify-send "$desc"
   eval "$res"

}



steps
popd
