Add proposed repository
#!/bin/bash
 
cat <<EOF>> /etc/apt/sources.list
deb http://archive.ubuntu.com/ubuntu/ hardy-proposed main restricted universe multiverse
deb-src http://archive.ubuntu.com/ubuntu/ hardy-proposed main restricted universe
EOF

