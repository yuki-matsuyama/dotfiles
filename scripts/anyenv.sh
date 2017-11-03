if [ -d ${HOME}/.anyenv ] ; then
  echo 'export PATH="$HOME/.anyenv/bin:$PATH"' >> ${HOME}/dotfiles/zshrc
  echo 'export PATH="$HOME/.anyenv/bin:$PATH"' >> ${HOME}/dotfiles/bashrc
  echo 'eval "$(anyenv init -)"' >> ${HOME}/dotfiles/zshrc
  echo 'eval "$(anyenv init -)"' >> ${HOME}/dotfiles/bashrc
  for D in `ls $HOME/.anyenv/envs`
  do
    export PATH="$HOME/.anyenv/envs/$D/shims:$PATH"
  done
fi

