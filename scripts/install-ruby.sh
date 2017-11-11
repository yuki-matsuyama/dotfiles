anyenv install rbenv
eval "$(anyenv init -)"
rbenv install $1
rbenv global  $1
rbenv rehash  $1
