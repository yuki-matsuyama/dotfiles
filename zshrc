#OSごとにファイルを読み込む
#aliasの設定
if [ -f ~/.oh-my-zsh/templates/zshrc.zsh-template ]
then
  source ~/.oh-my-zsh/templates/zshrc.zsh-template
fi
source ~/.oh-my-zsh/themes/blinks.zsh-theme
alias vi=/usr/local/bin/vim
alias search="find . -type f -print | xargs grep --color=auto -n "
alias php-cs="php-cs-fixer fix --config=${HOME}/dotfiles/php_cs --allow-risky=yes"
alias work="${HOME}/workspace"
alias gowork="/Users/yukimatsuyama/workspace/go/src"
alias vuework="/Users/yukimatsuyama/workspace/vue-spa"
alias dt='${HOME}/dotfiles'
plugins=(git)
#shellscript の実行
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

# fbr - checkout git branch (including remote branches), sorted by most recent commit, limit 30 last branches
fgco() {
  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

fssh() {
  ag '^host [^*]' ~/.ssh/config | cut -d ' ' -f 2 | fzf | xargs ssh
}

fstash() {
  local out q k sha
  while out=$(
    git stash list --pretty="%C(yellow)%h %>(14)%Cgreen%cr %C(blue)%gs" |
    fzf --ansi --no-sort --query="$q" --print-query \
        --expect=ctrl-d,ctrl-b);
  do
    mapfile -t out <<< "$out"
    q="${out[0]}"
    k="${out[1]}"
    sha="${out[-1]}"
    sha="${sha%% *}"
    [[ -z "$sha" ]] && continue
    if [[ "$k" == 'ctrl-d' ]]; then
      git diff $sha
    elif [[ "$k" == 'ctrl-b' ]]; then
      git stash branch "stash-$sha" $sha
      break;
    else
      git stash show -p $sha
    fi
  done
}

fmake(){
  cd $HOME/dotfiles && cat $HOME/dotfiles/Makefile | grep : | grep -v ^#|   sed  -e s/://g | awk '{ print $1  }'| fzf | xargs -o make
}

case ${OSTYPE} in
  darwin*)
    # ここに Mac 向けの設定
    ;;
  linux*)
    # ここに Linux 向けの設定
    ;;
esac

export PATH=$HOME/dotfiles/bin/:$HOME/dotfiles/google-cloud-sdk/bin/:$HOME/dotfiles/google-cloud-sdk/platform/google_appengine/:$PATH
eval "$(anyenv init -)"
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"
export PATH="$HOME/.anyenv/bin:$PATH"
