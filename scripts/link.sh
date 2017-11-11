#!/bin/bash
set -ex

files=('.editorconfig' '.gemrc' '.gvimrc' '.tigrc' '.tmux.conf' '.vimrc' '.zshenv' '.zpreztorc' '.zshrc' '.bashrc' '.config/dein')

mkdir -p ${HOME}/.config
for file in $files ; do
    if [ -L ${HOME}/${file} ]; then
        unlink ${HOME}/${file}
    elif [ -f ${HOME}/${file} ]; then
        mv ${file} $file.$(date "+%Y%m%d_%H%M%S")
    fi
done
