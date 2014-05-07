set -o nounset
cmd="date | tr -s ' ' | cut -d' ' -f4 | sed 's/[: ]//g'"
date1=$( eval "$cmd" )
dir_self=`dirname $0`
dir_backup=$dir_self/.old
echo '.old' > .gitignore

file_crontab_user=$dir_backup/user${date1}.cfg
file_crontab_root=$dir_backup/root${date1}.cfg
crontab -l  > $file_crontab_user 
sudo crontab -l  > $file_crontab_root 
