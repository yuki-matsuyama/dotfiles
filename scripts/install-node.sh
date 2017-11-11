anyenv install ndenv
eval "$(anyenv init -)"
ndenv install $1
ndenv global $1
ndenv rehash $1
