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

echo -n "Install git (y/n)? "
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
  case ${OSTYPE} in
    darwin*)
      echo "brew install git"
      ;;
    linux*)
      # ここに Linux 向けの設定
      echo "yum install -y git"
      ;;
  esac
else
    echo No
fi
echo -n "Install Fuzzy find (y/n)? "
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
   git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
else
    echo No
fi

