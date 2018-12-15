#OSごとにファイルを読み込む
#aliasの設定
if [ -f ~/.oh-my-zsh/templates/zshrc.zsh-template ]
then
  source ~/.oh-my-zsh/templates/zshrc.zsh-template
fi
source ~/.oh-my-zsh/themes/blinks.zsh-theme
alias vi=/usr/local/bin/vim
alias php-cs="php-cs-fixer fix --config=${HOME}/dotfiles/php_cs --allow-risky=yes"
alias kindle="open ~/Library/Containers/com.amazon.Kindle/Data/Library/Application Support/Kindle/My Kindle Content"
alias connect="ssh -i ~/.ssh/gcp_working -N yuki.matsuyama0123@35.200.60.220 -L 61111:35.200.60.220:22  -N -v"
plugins=(git)

fmakel(){
    # TODO ここで何も洗濯しない場合に一番初めのコマンドが渡される問題を修正
    command=$(cat ./Makefile | grep : | grep -v ^#|   sed  -e s/://g | awk '{ print $1  }'| fzf)
    if [ -z "$command" ]; then

    else
      make $command
    fi
}

fhistory() {
  command=$( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
  eval $command
}

zle -N fhistory  # _git_status関数をgit_status widgetとして登録
bindkey '^r' fhistory
fcat(){
    fzf --preview 'cat {}'
}

ftmux(){
    if tmux -q has-session 2>/dev/null; then
        if [ $(tmux list-sessions | wc -l) -gt 0 ]; then
            sessionname=$(tmux list-sessions | awk '{ print $1}' | sed 's/://g' | fzf)
            tmux a -t $sessionname
        else
            exec tmux new -s Login
        fi
    else
        exec tmux new -s Login
    fi
}

fcd() {
    local dir
    dir=$(ag '^project [^*]' ~/.project | cut -d ' ' -f 2 | fzf)
    cd "$dir"
    echo -n "Open in VsCode (y/n)? "
    read answer
    if [ "$answer" != "${answer#[Yy]}" ] ;then
      code "$dir"
    else
        echo No
    fi
}

fmake(){
    cd $HOME/dotfiles
    command=$(cat $HOME/dotfiles/Makefile |  grep -v "^#"| grep ":\s"|  awk '{ print $0  }'| sed  -e s/:// | fzf | tr '#' ' ' | awk '{print $(1)}')
    if [ -z "$command" ]; then
      cd -
    else
      make $command && cd -
    fi
}


# vim用の環境変数
export XDG_CONFIG_HOME=$HOME/.config
export LD_LIBRARY_PATH=${HOME}/local/lib:$LD_LIBRARY_PATH
# pyenvの設定
export PYENV_ROOT="$HOME/.pyenv"
# GOPATHの設定
export GOPATH=$HOME/workspace/go
export GOROOT=$HOME/workspace/go
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"
eval "$(direnv hook zsh)"
# ここでローカルで用意したものとgcp系のコマンドにPATHを通す
export PATH=$HOME/dotfiles/bin/:$HOME/dotfiles/google-cloud-sdk/bin/:$HOME/dotfiles/google-cloud-sdk/platform/google_appengine/:$PATH
export PATH=$PYENV_ROOT/bin:$PATH:$HOME/.nodebrew/current/bin:usr/local/sbin:/usr/local/bin:/usr/local:/usr/sbin:/sbin:$GOPATH/bin:$HOME/dotfiles/FlameGraph:
export TERM='xterm-256color'
export GOOGLE_APPLICATION_CREDENTIALS=$HOME/credentials/gcp/analyze-residential/analyze-residential-62968daf039a.json


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
