anyenv install goenv
eval "$(anyenv init -)"
goenv install $1
goenv global $1
goenv rehash $1
