SHELL=/bin/bash
PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin:/usr/games
#HOME=/home/guest
#MAILTO=guest
DISPLAY=:0 
* * * * *   /usr/bin/env > /tmp/cron-env
*/1 * * * *  bash -c "$dir_project/breath.sh project/bin/croning.sh"
* * * * * env > /home/dao04/config/env_dump.cfg
*/1 * * * * bash -c '/home/dao04/config/croning.sh alive
SHELL=/bin/bash
PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin:/usr/games
#HOME=/home/guest
#MAILTO=guest
DISPLAY=:0 
* * * * *   /usr/bin/env > /tmp/cron-env
*/1 * * * *  bash -c "$dir_project/breath.sh project/bin/croning.sh"
* * * * * env > /home/dao04/config/env_dump.cfg
*/1 * * * * bash -c '/home/dao04/config/croning.sh alive
SHELL=/bin/bash
PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin:/usr/games
#HOME=/home/guest
#MAILTO=guest
DISPLAY=:0 
* * * * *   /usr/bin/env > ~/Desktop/cron-env
* * * * *  bash -c "$dir_project/project/bin/croning.sh"


SHELL=/bin/bash
PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin:/usr/games
#HOME=/home/guest
#MAILTO=guest
DISPLAY=:0 
* * * * *   /usr/bin/env > ~/Desktop/cron-env
* * * * *  bash -c "$dir_project/project/bin/croning.sh"
* * * * * env > /home/dao04/config/env_dump.cfg
*/1 * * * * bash -c '/home/dao04/config/croning.sh alive
*/5 * * * * bash -c '/home/dao04/config/croning.sh suspend
DISPLAY=:0
SHELL=/bin/bash
PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games

* * * * * env > '/home/dao04/config/cfg/env_dump.cfg'
*/1 * * * * bash -c '/home/dao04/config/croning.sh alive'
SHELL=/bin/bash
PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin:/usr/games
HOME=/home/dao02
#MAILTO=dao02
DISPLAY=:0 
#* * * * * sleep 4 && echo 4 | flite && env > /tmp/env.output && notify-send cron job && gxmessage -file "/tmp/env.output" -title 'cron'
* * * * *   /usr/bin/env > /tmp/cron-env
#*/5 * * * * /usr/bin/python /usr/share/gnome-schedule/xwrapper.py c 54 # JOB_ID_54
*/11 * * * *  bash -c "/home/dao02/magnify_the_small/croning.sh 'motivation'"
*/23 * * * *  bash -c "/home/dao02/magnify_the_small/croning.sh 'lpi'"
*/4 * * * *  bash -c "/home/dao02/magnify_the_small/croning.sh 'suspend2'"
*/3 * * * *  bash -c "/home/dao02/magnify_the_small/croning.sh 'wallpaper'"
*/2 * * * *  bash -c "/home/dao02/magnify_the_small/croning.sh 'must'"
* * * * * env > /home/dao04/config/env_dump.cfg
*/1 * * * * bash -c '/home/dao04/config/croning.sh alive
*/5 * * * * bash -c '/home/dao04/config/croning.sh suspend
* * * * * env > /home/dao04/config/env_dump.cfg
*/1 * * * * bash -c '/home/dao04/config/croning.sh alive
*/5 * * * * bash -c '/home/dao04/config/croning.sh suspend
DISPLAY=:0
SHELL=/bin/bash
PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games

* * * * * env > '/home/dao04/config/cfg/env_dump.cfg'
*/1 * * * * bash -c '/home/dao04/config/croning.sh alive'
