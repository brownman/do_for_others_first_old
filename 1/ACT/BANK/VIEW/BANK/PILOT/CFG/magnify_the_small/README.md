independant scripts:
==
- this directory scrips should not be dependant on any exported function outside this dir

### choose a step based on your productivity level:
==

step0
==
- file: sos.sh
- code: basic loop
- target: suspend the computer every X minutes

step1
==
- file: tasker.sh
- code: advance loop
- example:
- update rooms/room1.txt with: 
```
reminder
new_word
sleep 60
list todo
suspend
```
- run: 
```
tasker.sh room1
```
- the script runs forever a loop which evaluates each line of the the text file (a line contain a task - which must be available under bank/)


step2
==
- file: croning.sh
- do: run a task every X minutes
- options: run as user/root
- utilize: cron service,crontab


Available Activities: 
==
- learn_one_word.sh
--- requirments: set a language + a list of words 

- list.sh: 
--- example: list.sh todo
--- will create a file: lists/todo.txt
--- do: pop-up a dialog which list the file and lets adding a new line

- reminder.sh: 
---- user: update the list of sentence for increasing your motivation
---- do:   speak a random line from the list

Shared scripts:
==
- translation.sh:
--- each task can utile this script
- suspend.sh: 
---- do: suspend the laptop for atleast X seconds - turning on before - will result in re-suspend


