## Google Compute Engineにsshで接続して作業する
ssh鍵の登録
以下を参考にして可能
https://qiita.com/NewGyu/items/3a65e837519297951e79
普通のssh公開鍵の登録は
authorized_keysへ公開鍵に登録する


sshできたらもろもろの準備を行う
まずはssh keyを作成してgithubにsshでアクセス可能にする
   19  ssh-keygen -t rsa -b 4096 -C "sh.ghdyji@gmail.com"
   20  cat ~/.ssh/id_rsa | pbcopy
sshコンフィグを以下のように修正する
   21  vim ~/.ssh/config
```
Host github.com
  User git
  Port 22
  HostName github.com
  IdentityFile ~/.ssh/id_rsa
  TCPKeepAlive yes
  IdentitiesOnly yes
```

vimを準備する
```
git clone git@github.com:katakatataan/dotfiles
cd dotfiles && make link
```

goの実行環境を準備する
```
git clone https://github.com/syndbg/goenv.git ~/.goenv
export GOENV_ROOT=$HOME/.goenv
export GOPATH=$HOME/projects/go/
export PATH=$HOME/projects/go/src/bin:$PATH
export PATH=$GOENV_ROOT/bin:$PATH
eval "$(goenv init -)"
```
depinstall

```
go get -u github.com/golang/dep/cmd/dep
dep ensure
```
文字化けの解決方法

```
https://www.apps-gcp.com/gce-casual-knowhow-01/
```


リモートをローカルにマウントする
```
```