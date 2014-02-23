#notify_send 'loader.sh'

files=$(ls -1 $ROOT_DIR/script/cfg/*.cfg)
for file in $files
do
    #echo "$file"
    #export "=$file
    . $file
done

## Load all files in support
#for file in `ls -1 $KOANS_DIR/support/*.sh`; do
#    notify-send "$file"
#  . $file
#done
#$KOANS_DIR/meditate.sh

#assertEqual 1 2
#exit
#cd ../public
#
#file1=$PWD/libs/cfg/vars.cfg
#file2=$PWD/libs/cfg/funcs.cfg
#file3=$PWD/libs/cfg/regex.cfg
#file4=$PWD/libs/cfg/debug.cfg
#file5=$PWD/libs/cfg/evaluating.cfg
#
#. $file1
#. $file2
#. $file3
#
#. $file4
#. $file5
#
