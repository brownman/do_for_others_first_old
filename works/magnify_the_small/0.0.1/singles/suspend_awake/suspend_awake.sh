#!/bin/bash
#http://www.howtoforge.com/linux_setting_suid_sgid_bits
#http://stackoverflow.com/questions/6119254/how-to-run-a-script-with-root-authority-in-linux
#url: http://superuser.com/questions/440363/can-i-make-a-script-always-execute-as-root
timeout=${TIMEOUT_SUSPEND_AWAKE:-60}
#sudo visudo /etc/sudoers
#ALL    ALL = (root) NOPASSWD: /absolute/path/to/your/script.sh
xcowsay "timeout is: $timeout"
sudo rtcwake -m mem -s $timeout
#&& firefox


