. $TIMERTXT_CFG_FILE

############
# about file:
# moto of the day: lock your progress in 1 file , design well !
#
# "PERSPECTIVE - time: manage time central - menu workflow"
# "ESSAY ADAY  - describe: idea, question, motivation"
# "CODE - control it - don't let it to control you"

########## time: management
 #gedit $product_txt 
    #gedit $ideas_txt &
    #gedit $questions_txt &
    #gedit $glossary_txt &
until="11:40"
finish="updating"
start="sending"
commitment="until: $until | from: $finish | to: $start"
NOW="update her"
REPORT="what do I want to tell her ?"
### points #####
P_SPORT_S=14
P_SPORT_L=1
P_DONE_T=1
################

### focus:  1 step aday #####
question="how to saperate story from code from points ?"
quote=""
product="1 file, 1 essay, minimum code, many points"
profit="from .txt to .db"
###
### script to run on next suspension:
#
#


temporary_thought=''
idea=""
motivation=""
mantra=""
more_efficient="from menus to repl"

##########
# quesion:  how to orgenize this file:
# 1. code 2.story 3.time-tasks
###########
# task:
# - update Kuka 
##########
# idea:
#
###########
# quote:
# it is a new day with a new idea
#

print_state(){
    
cyan "POINTS: "
echo -n "sport_standing: "
me "$P_SPORT_S"
echo -n "sport_laying: "
me "$P_SPORT_L"
echo -n "next: "
me "$P_SPORT_L"
echo -n "done tasks:"
me "$P_DONE_T"


}
print_story(){

cyan "STORY: "
echo -n "Mission:  "
yellow '1 story aday'
echo -n "Date:  "
white '9.7.2013,thusday'
echo -n "Place: "
me 'home'
echo -n "Feel like:  "
me 'creative'
echo -n "wonderful idea: "
me "moving from menus to pharsing"
}



input_repl(){

cyan "REPL"
while [ "$answer" != 'exit' ];do
    command=`cat $commands_txt | head -1`
    echo -n "latest command: "
    blue "$command"

    echo 'exec command ?' 
    read answer
    if [ "$answer" != '' ];then
    eval "$command"
    fi
    echo 'update command ?' 
    read answer
    update_file $commands_txt "$answer"
    


done


}
print_prespective()
{
cyan "PRESPECTIVE"
echo "point and tasks before code"
white 'add an effective idea:'

read answer
update_file $ideas_txt "$answer" 

cat $ideas_txt | head -2

}
edit()
{
gedit $done_txt &
gedit $timing_txt & 
gedit $todo_txt &
}

