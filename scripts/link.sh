#!/bin/bash
set -e

files=('tmux.conf' 'vimrc' 'zshrc' 'config/dein' 'php_cs' 'project')

mkdir -p ${HOME}/.config
for file in ${files[@]} ; do
    echo ${file}
    if [ -L ${HOME}/.${file} ]; then
        unlink ${HOME}/.${file}
    elif [ -f ${HOME}/.${file} ]; then
        mv ${HOME}/.${file} ${HOME}/.$file.$(date "+%Y%m%d_%H%M%S")
    fi
    ln -sf ${HOME}/dotfiles/${file} ${HOME}/.${file}
done
