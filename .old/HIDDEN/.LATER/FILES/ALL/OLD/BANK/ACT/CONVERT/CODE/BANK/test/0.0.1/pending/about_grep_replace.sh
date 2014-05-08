

test_replace_bye_to_bye(){
    file=/tmp/bye_to_bye.txt

    touch $file
    echo hi > $file
    res1=`cat $file`
    use bash.grep.replace
    replace bye bye $file
    res2=`cat $file`
    assertNotSame "$res1" "$res2"
}

trigger_runner
