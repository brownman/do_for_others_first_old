set -o nounset
set -e
step2(){
curl --url "smtps://smtp.gmail.com:465" --ssl-reqd \
  --mail-from "$GMAIL_USER@gmail.com" --mail-rcpt "$GMAIL_USER@gmail.com" \
  --upload-file /tmp/mail.txt --user "$GMAIL_USER:$GMAIL_PASSWORD" --insecure

}


#cmd=$1
#echo "$cmd"
#eval "$cmd"
step2
