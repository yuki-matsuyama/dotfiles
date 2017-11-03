#!/bin/bash
set -ex

mkdir -p ${HOME}/.config
if [ -L ${HOME}/.editorconfig ]; then
    unlink ${HOME}/.editorconfig
	unlink ${HOME}/.gemrc
	unlink ${HOME}/.gvimrc
	unlink ${HOME}/.tigrc
	unlink ${HOME}/.tmux.conf
	unlink ${HOME}/.vimrc
	unlink ${HOME}/.zshenv
	unlink ${HOME}/.zpreztorc
	unlink ${HOME}/.zshrc
	unlink ${HOME}/.bashrc
	unlink ${HOME}/.config/dein
fi
