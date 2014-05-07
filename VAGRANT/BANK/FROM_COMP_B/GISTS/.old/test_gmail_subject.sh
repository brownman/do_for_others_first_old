set -o nounset
set -e
step2(){
echo curl --url "smtps://smtp.gmail.com:465" --ssl-reqd \
  --mail-from "username@gmail.com" --mail-rcpt "john@example.com" \
  --upload-file mail.txt --user "$GMAIL_USER:$GMAIL_PASSWORD" --insecure

}


#cmd=$1
#echo "$cmd"
#eval "$cmd"
