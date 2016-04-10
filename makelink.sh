#!/bin/sh

home=${HOME}
dotdir=`pwd`
list='.bash_profile .bashrc .emacs.d .vimrc .zshrc .screenrc .gnuplot'

echo home directory is ${home}
echo dot  directory is ${dotdir}

for DFILE in ${list}
do
    echo make link --- ${DFILE}
    ln -si ${dotdir}/${DFILE} ${home}/${DFILE}
done
