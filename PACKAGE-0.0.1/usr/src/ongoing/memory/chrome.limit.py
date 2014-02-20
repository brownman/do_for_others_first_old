import sys, os, psutil

if len(sys.argv) == 2:
    try:
        limit = int(sys.argv[1])
    except:
        limit = 200 # default 200MB
else:
    limit = 200

uid = os.getuid()
for p in psutil.get_process_list():
    try:
        if (p.name == 'chrome' and any('type=renderer' in part for part in p.cmdline)
           and p.uid == uid):
            m = p.get_memory_info()
            #print p.pid,m, m.rss / 1024 / 1024, m.vms / 1024 / 1024
            if (m.rss / 1024 / 1024) > limit: # kill if rss is greater than limit
                print 'Killed', p.pid
                p.kill()
    except psutil.error.NoSuchProcess:
        pass
    except psutil.error.AccessDenied:
        pass
