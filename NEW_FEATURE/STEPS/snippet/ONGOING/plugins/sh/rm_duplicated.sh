#http://www.commandlinefu.com/commands/view/7930/find-duplicate-files-based-on-size-first-then-md5-hash#comment
#cksum  *.* | sort -n > filelist.txt
#cat filelist.txt
help='error: options are: print/remove'
if [  "$1" = ''  ];then
    echo "$help"
    exit
fi

print(){
find -not -empty -type f -printf "%s\n" | sort -rn | uniq -d | xargs -I{} -n1 find -type f -size {}c -print0 | xargs -0 md5sum | sort | uniq -w32 --all-repeated=separate
}

#link(){
#    echo 'change duplicated files to hard link'
#
#find . -xdev -type f -print0 | xargs -0 md5sum | sort | perl -ne 'chomp; $ph=$h; ($h,$f)=split(/\s+/,$_,2); if ($h ne $ph) { $k = $f; } else { unlink($f); link($k, $f); }'
#}
remove(){
find . -type f -print0|xargs -0 md5sum|sort|perl -ne 'chomp;$ph=$h;($h,$f)=split(/\s+/,$_,2);print "$f"."\x00" if ($h eq $ph)'|xargs -0 rm -v --
}

$@
