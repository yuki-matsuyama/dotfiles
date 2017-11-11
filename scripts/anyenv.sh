if [ ! -d "${HOME}/.anyenv" ]; then
    git clone https://github.com/riywo/anyenv ~/.anyenv;
    echo 'export PATH="$HOME/.anyenv/bin:$PATH"' >> ${HOME}/dotfiles/zshrc
    echo 'export PATH="$HOME/.anyenv/bin:$PATH"' >> ${HOME}/dotfiles/bashrc
    eval "$(anyenv init -)"
    for D in `ls $HOME/.anyenv/envs`
    do
        export PATH="$HOME/.anyenv/envs/$D/shims:$PATH"
    done
fi
