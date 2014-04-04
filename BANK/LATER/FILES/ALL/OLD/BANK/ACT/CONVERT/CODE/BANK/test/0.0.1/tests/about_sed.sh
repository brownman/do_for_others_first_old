#green "sed tool"
echo 'about sed'


test_wrap(){
local input='happy day'
local pattern='s/h/(&)/g'
local str=$( echo "$input" | sed "$pattern" )
# sed 's_h_b_g')
assertEquals "(h)appy day" "$str"
}

test_replace(){
#- Replace every occurrence of Nick with John
local input='nick nick'
local pattern='s/nick/john/g'
local str=$( echo "$input" | sed "$pattern" )
# sed 's_h_b_g')
assertEquals "john john" "$str"
}

test_capitalized(){
#- Replace every occurrence of nick/Nick with david
local input='nick Nick'
local pattern='s/[nN]ick/david/g'
local str=$( echo "$input" | sed "$pattern" )
# sed 's_h_b_g')
assertEquals "david david" "$str"
}

test_beggining(){
local input=" line1 line2"
local pattern='s_^_a_g'
local str=$( echo "$input" | sed "$pattern" )
assertEquals "a line1 line2" "$str"
}
trigger_runner
