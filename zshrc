#OSごとにファイルを読み込む
#aliasの設定
alias vi=/usr/local/bin/vim
alias search="find . -type f -print | xargs grep --color=auto -n "
# alias vim="nvim"
alias rancher="sudo docker run -d -p 8080:8080 rancher/server"
alias docker_host="ssh -i /Users/yukimatsuyama/credentials/docker_host/docker_host.pem ec2-user@52.198.178.239"

#zshの設定
plugins=(git)
#schemeの設定
# 以下はお好みでカスタマイズ！
#環境変数
export PATH=$PATH:$GOPATH/bin
export PYENV_ROOT=$HOME/.pyenv
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export ZSH=$HOME/.oh-my-zsh
#localにinstall際に必要tmux
export LD_LIBRARY_PATH=${HOME}/local/lib:$LD_LIBRARY_PATH PATH=/usr/local/sbin::/Users/$USER/.nodebrew/current/bin:/usr/local/bin:/Users/$USER/.mongodb/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/Applications/Postgres.app/Contents/Versions/9.5/bin:$PYENV_ROOT/bin:HOME/.pyenv/shims:$HOME/.nodebrew/current/bin:$HOME/local/bin/:$PATH
export PATH="$HOME/.composer/vendor/bin:$PATH"
export PATH="$HOME/.phpenv/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/local/bin:$PATH"
alias t="tmux attach || tmux"
#開発環境

#shellscript の実行
export TERM='xterm-256color'
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
  ag '^host [^*]' ~/.ssh/config | cut -d ' ' -f 2 | fzf | xargs -o ssh
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
case ${OSTYPE} in
  darwin*)
    export GOPATH=$HOME/.go
    eval "$(rbenv init -)"
    eval "$(phpenv init -)"
    eval "$(pyenv init -)"
    POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(time context dir vcs)
    POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status rbenv)
    POWERLEVEL9K_STATUS_VERBOSE=false
    POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"
    POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
    ZSH_THEME="powerlevel9k/powerlevel9k"
    source $ZSH/oh-my-zsh.sh
    # ここに Mac 向けの設定
    ;;
  linux*)
    # ここに Linux 向けの設定
    ;;
esac
