files=$( ls VCE/*.vce )
for file in  $files;do
    ls $file
    cp $file ~/.wine/drive_c/linux_duplicate
done
