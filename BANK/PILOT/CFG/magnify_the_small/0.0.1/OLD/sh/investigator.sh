#!/bin/bash
# about file:
# plugin:   ask a question +  try to give answer + save the command result
#. $TIMERTXT_CFG_FILE



help_option='try a command and save the results to a file'
command=''

answer=$( gxmessage -title 'enter a command' -file $TODAY_DIR/commands.txt -entry -ontop -timeout 30 )

answer=$( answerYN -title 'execute command?' )
if [];then
  eval answer
fi

answer=$( gxmessage -title 'save results:' -file $TODAY_DIR/commands.txt -entry -ontop -timeout 30 )





