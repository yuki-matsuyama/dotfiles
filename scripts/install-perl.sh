anyenv install plenv
eval "$(anyenv init -)"
plenv install $1
plenv global $1
plenv rehash $1
