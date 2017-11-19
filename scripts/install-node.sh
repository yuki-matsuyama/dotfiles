curl -L git.io/nodebrew | perl - setup

nodebrew install-binary $1
nodebrew global $1
nodebrew rehash $1
