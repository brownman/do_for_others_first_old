#!/bin/sh

# any2pandoc.sh
#
# A shell script that tries its best to convert documents thrown at it
# to pandoc's extended markdown.
#
# https://gist.github.com/1181510
#
# Depends on: 
#
# pandoc:    http://johnmacfarlane.net/pandoc/
#            a utility for converting lots of things to lots of things
# textutil:  a built-in OS X utility for converting lots of things to 
#            lots of things.
# pdftohtml: http://pdftohtml.sourceforge.net/
#            a utility for converting pdf to html
#


if [ ! $(which pandoc) ]; then
	echo "pandoc not found: unable to process files."
	exit
fi

for file in "$@"
do
    base="${file%%.*}"
    ext="${file#*.}"
	case $ext in
		doc | docx | webarchive | rtf | rtfd | odt )
			if [ ! $(which textutil) ]; then
				echo "textutil not found:"
				echo "  unable to process doc, docx, webarchive, rtf, rtfd, or odt files"
			    exit
			fi
    		textutil -format "$ext" -convert "html" -stdout "$file" \
				| pandoc -f html -s -o "${base}.markdown"
		;;
		pdf )
			if [ ! $(which pdftohtml) ]; then
				echo "pdftohtml not found: unable to process pdf files."
				exit
			fi
			pdftohtml -noframes -stdout "$file" \
				| pandoc -f html -o "${base}.markdown"   
        ;;
	    tex )
		    pandoc -f latex -s "$file" -o "${base}.markdown"
		;;
		* )
            pandoc -s  "$file" -o "${base}.markdown"
		;;
	esac
done
