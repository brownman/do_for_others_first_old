#!/bin/bash
# qbot.sh
# Author: Mendel Cooper
# v. 0.1.1, reldate: 07 June 2008 [Expanded to 10-letter words.]
# License: GPL3

#  A Quackey bot that convincingly demonstrates
#+ how much smarter than a human a simple shell script is.
#  Humbling, isn't it?

#  Requires:
#  --------
#  /usr/share/dict/word.lst
#  A suggested list is the script author's "yawl" word list package.
#  http://bash.neuralshortcircuit.com/yawl-0.3.2.tar.gz
#  or
#  http://ibiblio.org/pub/Linux/libs/yawl-0.3.2.tar.gz
#
#  Also, the "anagram" utility, which is part of the "yawl" package,
#+ installed in /usr/local/bin.  


MAXNUM=15       # Maximum number of words to find/display.

if [ -z "$1" ]  # Failed to pass letterset as command-line parameter.
then            # Greeting.
  clear
  echo "Welcome to the Quackey bot."
  echo
  echo "Enter letter set [typically 10 - 13 letters]: "
  read ls
else
  ls="$1"       # If letterset assigned, then greeting unnecessary.
fi

agram ()
{     # Store results in arrays.
word3=(      $(anagram "$ls" | grep "^...$"         -m $MAXNUM) )
word4=(      $(anagram "$ls" | grep "^....$"        -m $MAXNUM) )
word5=(      $(anagram "$ls" | grep "^.....$"       -m $MAXNUM) )
word6=(      $(anagram "$ls" | grep "^......$"      -m $MAXNUM) )
word7=(      $(anagram "$ls" | grep "^.......$"     -m $MAXNUM) )
word8=(      $(anagram "$ls" | grep "^........$"    -m $MAXNUM) )
word9=(      $(anagram "$ls" | grep "^.........$"   -m $MAXNUM) )
word10=(     $(anagram "$ls" | grep "^..........$"  -m $MAXNUM) )
# word11=(   $(anagram "$ls" | grep "^...........$" -m $MAXNUM) )
# etc.
}

display ()
{
clear
echo "Letter set: "$ls""
echo "Displaying just the first $MAXNUM words in each category ..."
echo
echo "Threes:  Fours:  Fives:   Sixes:   Sevens:   Eights:    Nines:      Tens:"
echo "------------------------------------------------------------------------------"

for index in `seq 0 $MAXNUM`
do
  echo -n "${word3[index]}      "
  echo -n "${word4[index]}    "
  echo -n "${word5[index]}    "
  echo -n "${word6[index]}   "
  echo -n "${word7[index]}   "
  echo -n "${word8[index]}   "
  echo -n "${word9[index]}   "
  echo -n "${word10[index]}"
# echo -n "${word11[index]}"
# etc.
  echo
done

echo "And possibly many, many more . . ."; echo
}

# --- #
agram
display
# --- #

#  Fast! Requires only a few seconds on a 1.6 Ghz single-processor system,
#+ because of all the heavy lifting done by "anagram" --
#+ a compiled C program.

exit

#  Strange how the bot was so much simpler to code
#+ than the actual Quackey game.
