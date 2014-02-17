echo "grep tool"


test_end(){
local input='happy day'
local res=$(echo -e "file.sh~\nfile.sh" | grep -v '~')
 assertEquals "$res" 'file.sh'
}
 
. $runner
