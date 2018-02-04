#!/bin/bash
set -e

files=('editorconfig' 'gemrc' 'gvimrc' 'tigrc' 'tmux.conf' 'vimrc' 'zshenv' 'zpreztorc' 'zshrc' 'bashrc' 'config/dein' 'php_cs' 'docker-command' 'project')

mkdir -p ${HOME}/.config
for file in ${files[@]} ; do
    echo ${file}
    if [ -L ${HOME}/.${file} ]; then
        unlink ${HOME}/.${file}
    elif [ -f ${HOME}/.${file} ]; then
        mv ${HOME}/.${file} $(HOME)/.$file.$(date "+%Y%m%d_%H%M%S")
    fi
    ln -sf ${HOME}/dotfiles/${file} ${HOME}/.${file}
done
