


ensure_script(){
    
    local str_tag="$1"
    local file=$0
    local msg="check if file has tag"
echo "file:$file"
echo "tag: $tag"

local str_res=$( cat $file | grep $str_tag )
local res=$?

echo "res: $res"

echo "str_res: $str_res"

}



steps(){
ensure_script info
}


steps
