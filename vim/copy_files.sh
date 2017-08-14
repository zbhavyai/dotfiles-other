#!/bin/bash
MYDIR=$( cd $(dirname $0) ; pwd -P )
BASHDIR=$HOME

# function makesymlink 
#   Move the old file to a saved location (only if it wasn't
#   a symlink). It is likely that this symlink will be pointing
#   to where we want it to, but it is trivial to just remove it,
#   add it again, and be sure about it.
function makesymlink {
    if [ -h $2 ]; then
        rm $2
    elif [ -f $2 ]; then
        echo "$2 exists. Moving it to $2.old"
        mv $2 $2.old
    fi
    ln -s $1 $2
}

# Copy vimrc file
for file in .{vimrc,gvimrc}
do
    [ -r "$MYDIR/$file" ] && [ -f "$MYDIR/$file" ] && \
        echo "Symlinking $file" && \
        makesymlink $MYDIR/$file $HOME/$file;
done;
unset file;

# Download vundle
if [ ! -d "$HOME/.vim/bundle/Vundle.vim" ]; then
    echo "Downloading Vundle for Vim"
    mkdir -p ~/.vim/bundle/Vundle.vim
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

# Copy ctags.vim file
makesymlink $MYDIR/cscope.vim $HOME/.vim/cscope.vim

# Copy ftplugin files
mkdir -p ~/.vim/ftplugin
makesymlink $MYDIR/python.vim $HOME/.vim/ftplugin/python.vim
makesymlink $MYDIR/tex.vim $HOME/.vim/ftplugin/tex.vim