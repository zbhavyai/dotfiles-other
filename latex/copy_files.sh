#!/bin/bash
MYDIR=$( cd $(dirname $0) ; pwd -P )
LATEXDIR="$HOME/mylatex"

# function makesymlink 
#   Move the old file to a saved location (only if it wasn't
#   a symlink). It is likely that this symlink will be pointing
#   to where we want it to, but it is trivial to just remove it,
#   add it again, and be sure about it.
function makesymlink {
    if [ -f $2 ]; then
        if [ -h $2 ]; then
            rm $2
        else
            mv $2 $2.old
        fi
    fi
    ln -s $1 $2
}

# Make a link to the config.fish file
mkdir -p $LATEXDIR
echo "Symlinking preamble"
makesymlink $MYDIR/preamble.tex $LATEXDIR/preamble.tex
echo "Symlinking defs"
makesymlink $MYDIR/defs.tex $LATEXDIR/defs.tex
