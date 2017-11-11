anyenv install pyenv
eval "$(anyenv init -)"
pyenv install $1
pyenv global $1
pyenv rehash $1
