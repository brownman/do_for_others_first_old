#!/bin/sh

function mkchroot
{
    [ $# -lt 2 ] && return

    dest=$1
    shift
    for i in "$@"
    do
        # Get an absolute path for the file
        [ "${i:0:1}" == "/" ] || i=$(which $i)
        # Skip files that already exist at target.
        [ -f "$dest/$i" ] && continue
        if [ -e "$i" ]
        then
            # Create destination path
            d=`echo "$i" | grep -o '.*/'` &&
                mkdir -p "$dest/$d" &&
                # Copy file
            cat "$i" > "$dest/$i" &&
                chmod +x "$dest/$i"
        else
            echo "Not found: $i"
        fi
        # Recursively copy shared libraries' shared libraries.
        mkchroot "$dest" $(ldd "$i" | egrep -o '/.* ')
    done
}

mkchroot "$@"
Its first argument is t
