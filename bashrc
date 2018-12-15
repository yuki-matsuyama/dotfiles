#OSごとにファイルを読み込む
#aliasの設定
if [ -f ~/.bash_profile ]; then
  . ~/.bash_profile
fi
alias vi=/usr/local/bin/vim
alias search="find . -type f -print | xargs grep --color=auto -n "
plugins=(git bundler osx rake ruby)
#shellscript の実行
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}
# さいあ
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

fmake(){
  cd $HOME/dotfiles && cat $HOME/dotfiles/Makefile | grep : | grep -v ^#|   sed  -e s/://g | awk '{ print $1  }'| peco | xargs make
}

case ${OSTYPE} in
  darwin*)
    # ここに Mac 向けの設定
    ;;
  linux*)
    # ここに Linux 向けの設定
    ;;
esac
#一番最初に修正
export TOOLS_DIR=$HOME/dotfiles
#一番最初に修正

###-tns-completion-start-###
if [ -f /Users/yukimatsuyama/.tnsrc ]; then
    source /Users/yukimatsuyama/.tnsrc
fi
###-tns-completion-end-###
export PATH=$HOME/.nodebrew/current/bin:$PATH

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
