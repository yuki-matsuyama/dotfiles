anyenv install phpenv
eval "$(anyenv init -)"
phpenv install $1
phpenv global $1
phpenv rehash $1
