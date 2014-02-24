
#
#
##echo "$timer_sh"
#declare -i num 
##declare -i max  
############################ choose your destiny ########################
#export workflow_suspension="run"
#export workflow_periodic="suspend->tasks"
#export workflow_morning="blog,readme,record"
#export workflow_money="find task -> increase points"
#export workflow_motivation="find quote -> translte it"
#########################################################################
#
#cyan "prespective|you are here"
#echo "suspend|testing|menus|scrap|periodic|task|motivation" | grep menus
#
commitment1(){

    str6=$( date | awk -F ' ' '{print $4}' )
    echo -n "dear:  "
    green "$NAME1"
    echo -n "the time is: "
    red "$str6"
    echo -n  "you commited to the next obligation:  "
    str=`cat  $commitment_txt | head -1`
    white "$str"


    #$timer_sh  translate  "$str" "it"  
    #$timer_sh  translate  "$str" "ru"  
    #$timer_sh  translate  "$str" "tl"  
    #$timer_sh  translate  "$str" "ar"  
    #$timer_sh  translate  "$str" "ru"  
    #( echo "$str" | flite &)

    #"until X i finish doing Y and start doing Z"
    cyan 'update commitment ?'
    ( echo4 "$str" &)
    read answer
    if [ "$answer" = 'y' ];then


        cyan 'until:'
        read x
        cyan 'I finish doing:'
        read y
        cyan 'and start doing:'
        read z

        if  [ "$x" != '' ]     && [ "$y" != '' ]    && [ "$z" != '' ] 
        then
            echo "until $x - I finish  $y - and start  $z" > $commitment_txt
            exiting
        else
            echo 'error on input'
            exiting
        fi
    elif [ "$answer" = 'n' ];then

        red "Must log in to continue ?"

        read        answer
        if [  $answer = y ];then

            green "$NAME1 is commited ! "
        else

            $timer_sh suspend
        fi
    else
        exiting

    fi


}


if [ "$1" = 'menus' ];then
    $PUBLIC_DIR/menus.sh
elif [ "$1" = 'motivation'  ];then
    echo 'assuming you wants alittle attention:'
    #echo 'series: motivation, prespective, commi'

    $SCREENS_DIR/motivation.sh  
elif [ "$1" = 'periodic' ];then
    $SCREENS_DIR/periodic.sh "$workflow" #"$2" "$
else



#result=` echo "$workflow_morning" | grep -o "$1" `
if [ "$1" = 'suspend' ];then
    $timer_sh series "$series_on_suspend"
elif [ "$1" = 'testing' ];then
    $PUBLIC_DIR/koans/meditate.sh
elif [ "$1" = 'menus' ];then
    $PUBLIC_DIR/menus.sh
elif [ "$1" = 'scrap' ];then
    #$TASKS_DIR/scrap.sh "$2" "$3"
    $PUBLIC_DIR/koans/meditate.sh
elif [ "$1" = 'periodic' ];then
    $SCREENS_DIR/periodic.sh #"$2" "$
elif [ "$1" = 'task'  ];then
    $timer_sh "$2"
elif [ "$1" = 'motivation'  ];then
    echo 'assuming you wants alittle attention:'
    #echo 'series: motivation, prespective, commi'

    $SCREENS_DIR/motivation.sh  
else


workflow='schedule,edit,sleep,suspend,edit,sleep,sleep,remind_me'
