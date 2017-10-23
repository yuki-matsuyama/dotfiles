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

export NGINX_ACCESS_LOG=/var/log/nginx/access.log
export MYSQL_SLOW_LOG=/tmp/mysql-slow.log
export TOOLS_DIR=/home/isucon/isucon_tools
export APP_LOG=

## deployのために使用する変数

export IPADDR=isucon7
export USERNAME=isucon

## databaseの操作に関する変数

export DB_PASS=isucon
export DB_USER=isucon
export DB_NAME=isuda

# optionnaly errorログの場所を見る

export NGINX_ERROR_LOG=/var/log/nginx/error.log
export MYSQL_ERROR_LOG=/var/log/mysql/error.log
export PATH=$HOME/dotfiles/bin/:$PATH
