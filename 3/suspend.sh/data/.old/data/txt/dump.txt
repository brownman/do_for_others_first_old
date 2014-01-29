
Quote: 
----------
"Magnify The Small" (Wayne Dyer)

About the project:
------------------
- project:
    - goal:
             - increase awareness for the clock
             - get prespective through time
             - increase motivation to deal with your tasks
             - increase efficiency by doing more and more order
    -  hope:
             - it will serve others too.

pipes:
-------
- the project consist of 3 projects:
    - 1. a koan project   -  where we update the unit-tests
    - 2. a tasks project  -  where we update our daily tasks and add motivation sentences
    - 3. an image project -  where we build a picture of our day by accumulating notifications 

life-cycle: 
--------------------
- update:
    - daily tasks:
        - edit blank.yaml
    - motivations:
        - edit glossary.txt

- push koans forward:
    - first run: 
        - watchr linux.watchr
    - update a koan:
        - edit and save a unit-test file

- the system will:
    - show a notification regarding an error in the code 
    - play a motivation sentence and its translation 
    - remind you of your life's tasks
    
- the daily product:
    - the notifications will be accumulated in a log file
    - we will compile this log file to a colorful and meaningful picture


tools and services:
---------
- google calender/tasks/blogger/youtube
- linux tools: notify-send, gxmessage, flite


directory structure:
----------------------
- root:
    - config/timer.cfg    | user set preferences
    - conifg/workflow.txt | user set list of tasks to execute one after another 

    - public/plugins/suspend.sh     | plugin example: suspend the computer
    - public/plugins/translation.sh | plugin example: translate a sentance to a choosen forign-languages

    - automatic.sh    
        - parse: workflow.cfg - execute listed tasks - one after another
        - run this script every 5 minutes
        
    - manual.sh    
        - update blog:
            - service: google blogger
            - use:     upload cfg/blank.txt
        - update youtube:
            - service: youtube
            - use:     recored your morning wishes to youtube

videos:
---------------
- [ 11-7-13 imagine.sh - break task to mini-tasks ](http://ascii.io/a/4113).
- [ 25-7-13 plugin: translation: choose random line from motivation.txt and say it to many languages ](http://ascii.io/a/4337).



news:
------------
- idea:
    - percieve yourself as an emotional human being
            
- take action:      save your thoughts:
    - each task we want to do - rise some emotion - note it down!

- how:     draw a colorful image of your feelings
- example:
    - draw your emotions: 
        - one can represent his fear as a grey cloud with a text description in its middle.

- be efficient:
    - look at yesturday picture - and observe it as a true picture of your mind
    - be productive about how you deal with your fears - don't pospond a task


- be cool regarding your fears:
    - how: look deep into this picture and grasp your map of feelings 
    - look fear in its eyes - don't ignore it - increase your self compation
    - comminucate with your higher self

- be creative:
    - invite yourself tomorrow to deal again with your fears - make them smaller and smaller 
    - entertain yourself with a picture which is creative warm and inspiring


recent db dump:
------------
- riddle:
1,1,1,1
- koan
67,"",14:55,tasks_sh,"","","",empty
66,"",12:02,tasks_sh,cfg1,pairs3,"",empty
65,"",11:25,tasks_sh,cfg1,pairs3,"",empty
64,"",11:24,tasks_sh,pairs3,"","",empty
63,"",11:21,tasks_sh,"","","",empty
62,"",11:09,tasks_sh,"","","",empty
61,"",11:01,tasks_sh,"","","",empty
60,"array pairs",10:56,tasks_sh,cfg1,pairs,", key : it, value: ac",", key  : it, value: ac"
59,"array pairs",10:56,tasks_sh,cfg1,pairs,", key : it, value: ac",", key  : it, value: ac"
58,"array pairs",10:55,tasks_sh,cfg1,pairs,"",", key  : it, value: ac"
57,"array pairs",10:54,tasks_sh,cfg1,pairs,"",", key  : it, value: ac"
56,"array pairs",10:53,tasks_sh,cfg1,pairs,"",empty
55,"array pairs",10:52,tasks_sh,cfg1,pairs,"",empty
54,"array pairs",10:52,tasks_sh,cfg1,pairs,"",empty
53,"array pairs",10:51,tasks_sh,cfg1,pairs,"",empty
52,"array pairs",10:50,tasks_sh,cfg1,pairs,"",", key  : it, value: ac"
51,"array pairs",10:50,tasks_sh,cfg1,pairs,"",empty
50,"array pairs",10:49,tasks_sh,cfg1,pairs,"",empty
49,"array pairs",10:49,tasks_sh,cfg1,pairs1,"","str:  User: greycat, full name: Greg Wooledge."
48,"array pairs",10:49,tasks_sh,cfg1,pairs1,"",hi
47,"array pairs",10:48,tasks_sh,cfg1,pairs1,"",empty
46,"array pairs",10:47,tasks_sh,cfg1,pairs1,"",empty
45,"array pairs",10:46,tasks_sh,cfg1,pairs,"",empty
44,"array pairs",10:45,tasks_sh,cfg1,pairs,"",empty
43,"array pairs",10:44,tasks_sh,cfg1,pairs,"",empty
42,"array pairs",10:43,tasks_sh,cfg1,pairs,"",empty
41,"array pairs",10:41,tasks_sh,cfg1,pairs,jjj,empty
40,"array pairs",10:40,tasks_sh,cfg1,pairs,jjj,empty
39,"array pairs",10:38,tasks_sh,cfg1,pairs,jjj,empty
38,"array pairs",10:37,tasks_sh,cfg1,pairs,jjj,empty
37,"array pairs",10:33,tasks_sh,cfg1,pairs,jjj,"str: , key  : 0, value: ac"
36,"array pairs",10:25,tasks_sh,cfg1,pairs,jjj,"str: , key  : 0, value: 1"
35,"array pairs",10:24,tasks_sh,cfg1,pairs,jjj,"str: "
34,"array pairs",10:23,tasks_sh,cfg1,pairs,jjj,"str: "
33,"array pairs",10:23,tasks_sh,cfg1,pairs,jjj,empty
32,"array pairs",10:22,tasks_sh,cfg1,pairs,jjj,empty
31,"array pairs",10:22,tasks_sh,cfg1,pairs,2,empty
30,"array pairs",10:20,tasks_sh,cfg1,pairs,2,empty
29,"array pairs",10:17,tasks_sh,cfg1,pairs,2,empty
28,"array pairs",10:16,tasks_sh,cfg1,pairs,2,empty
27,"array pairs",10:16,tasks_sh,cfg1,pairs,2,empty
26,"array pairs",10:16,tasks_sh,cfg1,pairs,2,empty
25,"array pairs",10:16,tasks_sh,cfg1,pairs,2,"key  : 0"
24,"array pairs",10:14,tasks_sh,cfg1,pairs,2,"key  : 0"
23,"array pairs",10:14,tasks_sh,cfg1,pairs,2,empty
22,"array pairs",10:13,tasks_sh,cfg1,pairs,2,empty
21,"array pairs",10:11,tasks_sh,cfg1,pairs,2,empty
20,"",10:10,tasks_sh,cfg1,pairs,2,empty
19,"",10:10,tasks_sh,cfg1,pairs,2,failed
18,"",10:09,tasks_sh,cfg1,pairs,2,failed
17,"",10:08,tasks_sh,cfg1,pairs,2,failed
16,"",09:34,tasks_sh,"","","",equal
15,"",09:33,tasks_sh,cfg1,meteor,"",equal
14,"",08:54,tasks_sh,cfg1,"sleep2 ab cd 4","",equal
13,"",08:53,tasks_sh,cfg1,"sleep2 ab cd 4","",equal
12,"",08:53,tasks_sh,cfg1,"sleep2 ab cd 4","",equal
11,"",15:12,tasks_sh,cfg1,"sleep2 ab cd 4","",equal
10,"",14:29,tasks_sh,motivation,sport,"",equal
9,1,14:19,tasks_sh,1,1,1,failed
8,1,14:19,tasks_sh,1,1,1,failed
7,1,12:13,tasks_sh,1,1,1,v
6,1,12:13,tasks_sh,1,1,1,v
5,1,12:13,tasks_sh,1,1,1,v
4,1,12:13,tasks_sh,1,1,1,v
3,1,12:13,tasks_sh,1,1,1,v
2,1,12:13,tasks_sh,1,1,1,v
1,1,1,1,1,1,1,1
     1	although there was  a big tree beside him
     2	although there was  a big tree beside him
     3	he hided behind the bush
     4	where was he
     5	but she could always call her friend
     6	she had herself to talk to
     7	she had a good company
     8	but she was still happy
     9	but she was still happy
    10	but she was still happy
    11	but she was stil happy
    12	the ant had a small brain
    13	the ant had a small brain
    14	about his good friend - the ant
    15	exit
    16	and he was happy to hear the good news
    17	there was also an elephant though
    18	there was a little ant
    19	once upon a time
