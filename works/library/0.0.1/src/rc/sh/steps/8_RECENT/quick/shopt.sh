7. Bash test Command Example

test command evaluates the conditional expression and returns zero or one based on the evaluation. Refer the manual page of bash, for more test operators.

#! /bin/bash

if test -z $1
then
        echo "The positional parameter \$1 is empty"
fi
#http://www.thegeekstuff.com/2010/08/bash-shell-builtin-commands/

#http://harrykar.blogspot.co.il/2011/02/bash-bourne-again-shell.html
