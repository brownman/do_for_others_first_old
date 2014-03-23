 2147  git push origin develop
 2148  git remote -v
 2149  vi .git/config
 2150  git push origin develop
 2151  vi .git/config
 2152  git push origin develop
 2153  cd ~/.ssh
 2154  ssh-keygen -t rsa -C "brownman556@gmail.com"
 2155  ssh-add id_rsa
 2156  xclip -sel clip < ~/.ssh/id_rsa.pub
 2157  ssh -T git@github.com
 2158  xclip -sel clip < ~/.ssh/id_rsa.pub
 2159  ssh -T git@github.com
 2160  history 15
 2161  history 15 > rsa.sh
