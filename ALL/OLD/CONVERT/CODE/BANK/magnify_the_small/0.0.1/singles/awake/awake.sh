#!/bin/bash
print_script
#http://www.howtoforge.com/linux_setting_suid_sgid_bits
#http://stackoverflow.com/questions/6119254/how-to-run-a-script-with-root-authority-in-linux
#url: http://superuser.com/questions/440363/can-i-make-a-script-always-execute-as-root
timeout=${1:-60}
#sudo visudo /etc/sudoers
#ALL    ALL = (root) NOPASSWD: /absolute/path/to/your/script.sh
proxy "xcowsay awaking in: $timeout seconds"
proxy "flite -t awaking in $timeout seconds"
sleep 4

util=/usr/sbin/rtcwake

cmd="$util -m mem -s $timeout"
echo "$cmd"
sleep 4
eval "$cmd"
#&& firefox


