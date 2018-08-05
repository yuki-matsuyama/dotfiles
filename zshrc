#OSごとにファイルを読み込む
#aliasの設定
if [ -f ~/.oh-my-zsh/templates/zshrc.zsh-template ]
then
  source ~/.oh-my-zsh/templates/zshrc.zsh-template
fi
source ~/.oh-my-zsh/themes/blinks.zsh-theme
alias vi=/usr/local/bin/vim
alias php-cs="php-cs-fixer fix --config=${HOME}/dotfiles/php_cs --allow-risky=yes"
# alias python="python3"
plugins=(git)

# data flow of shellscript
# 1. データの取得(特定のシステムコマンドもしくはローカルで持つ配列)grep ならagを使った方が良い
# 2. データの整形置換ならsed 今あるものを編集して保持するならawk データがテーブル形式なら極力cutを使用する
# 3. 式の評価$()を使いましょう
# 4. OSに依存するならOSTYPEを使用する
fmakel(){
      cat ./Makefile | grep : | grep -v ^#|   sed  -e s/://g | awk '{ print $1  }'| fzf | xargs -o make
}

fssh() {
  ag '^host [^*]' ~/.ssh/config | cut -d ' ' -f 2 | fzf | xargs ssh
}

fcd() {
    local dir
    dir=$(ag '^project [^*]' ~/.project | cut -d ' ' -f 2 | fzf)
    cd "$dir"
}

fmake(){
    cd $HOME/dotfiles && cat $HOME/dotfiles/Makefile |  grep -v "^#"| grep ":\s"|  awk '{ print $0  }'| sed  -e s/:// | fzf | tr '#' ' ' | awk '{print $(1)}' | xargs -o make
}

case ${OSTYPE} in
  darwin*)
    # ここに Mac 向けの設定
    ;;
  linux*)
    # ここに Linux 向けの設定
    ;;
esac

# vim用の環境変数
export XDG_CONFIG_HOME=$HOME/.config
export LD_LIBRARY_PATH=${HOME}/local/lib:$LD_LIBRARY_PATH
# pyenvの設定
export PYENV_ROOT="$HOME/.pyenv"
# GOPATHの設定
export GOPATH=$HOME/workspace/go
# ここでローカルで用意したものとgcp系のコマンドにPATHを通す
export PATH=$HOME/dotfiles/bin/:$HOME/dotfiles/google-cloud-sdk/bin/:$HOME/dotfiles/google-cloud-sdk/platform/google_appengine/:$PATH
export PATH=$PYENV_ROOT/bin:$PATH:$HOME/.nodebrew/current/bin:usr/local/sbin:/usr/local/bin:/usr/local:/usr/sbin:/sbin:$GOPATH/bin:
export TERM='xterm-256color'
# export GOOGLE_APPLICATION_CREDENTIALS=$HOME/credentials/gcp/residential-map/residential-maps-680ddd917cb0.json
export GOOGLE_APPLICATION_CREDENTIALS=$HOME/credentials/gcp/analyze-residential/analyze-residential-62968daf039a.json

###-tns-completion-start-###
if [ -f /Users/yukimatsuyama/.tnsrc ]; then
    source /Users/yukimatsuyama/.tnsrc
fi

export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"
eval "$(pyenv init -)"
