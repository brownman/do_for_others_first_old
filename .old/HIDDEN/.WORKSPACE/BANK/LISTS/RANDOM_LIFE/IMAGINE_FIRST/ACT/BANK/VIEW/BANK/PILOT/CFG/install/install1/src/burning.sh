

test_random_line(){
    file=/tmp/1.txt
echo hello1  >> $file
echo hello2  >> $file

cmd="random_line $file"
line=$( commander "$cmd" )

assertNotEqual "$line" ""

print_info "$line"
}
pending_print_var(){
str="abc"
#res=$( print_var str )
#assertEqual "$res" x
}
