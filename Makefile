TOOLS_DIR=$(HOME)/dotfiles
NGINX_ACCESS_LOG='/var/log/nginx/access_log'
NGINX_ERROR_LOG='/var/log/nginx/error_log'
MYSQL_SLOW_LOG='/var/log/mysql/'
MYSQL_ERROR_LOG="/var/log/mysql/mysql_error_log"
PLATFORM='Darwin'

link: #zhsrcなどのdotfileのシンボリックリンクを張るすでにあるファイルはタイムスタンプで避難させる
	chmod +x $(HOME)/dotfiles/scripts/link.sh
	$(HOME)/dotfiles/scripts/link.sh

install-docker-to-debian-gcp-compute-engin: # install docker to debian
	chmod +x $(HOME)/dotfiles/scripts/install-docker-to-debian-gcp-compute-engin.sh
	$(HOME)/dotfiles/scripts/install-docker-to-debian-gcp-compute-engin.sh

install-docker-compose-to-debian-gcp-compute-engin: # install docker to debian
	chmod +x $(HOME)/dotfiles/scripts/install-docker-compose-to-debian-gcp-compute-engin.sh
	$(HOME)/dotfiles/scripts/install-docker-compose-to-debian-gcp-compute-engin.sh

docker-ctop: # dockerコンテナのcpu負荷をそれぞれに検出https://github.com/bcicen/ctop
	ctop

docker-clean: # dockerのimage以外を全て削除
	chmod +x $(HOME)/dotfiles/scripts/clean.sh
	$(HOME)/dotfiles/scripts/clean.sh

isucon-prebench: # ベンチマークを撮る際にファイルの置き場所をタイムスタンプをつけて変更
	chmod +x $(HOME)/dotfiles/scripts/prebench.sh
	$(HOME)/dotfiles/scripts/prebench.sh

isucon-install-myprofiler: # mysqlのプロファイラーをinstall　TODOyum apt-get macように用意するhttps://github.com/KLab/myprofiler
	wget https://github.com/KLab/myprofiler/releases/download/0.1/myprofiler.linux_amd64.tar.gz
	tar xf myprofiler.linux_amd64.tar.gz -C $(HOME)/dotfiles/bin
	rm myprofiler.linux_amd64.tar.gz

isucon-install-pt-query-digest: # mysqlスロークエリのログを解析するためのツール
	wget percona.com/get/pt-query-digest -P $(HOME)/dotfiles/bin
	chmod +x $(HOME)/dotfiles/bin/pt-query-digest

isucon-postgres-report: # 新たに用意したpostgres用のツール
	pgbadger --help

isucon-install-alp: # 特定のlogのフォーマットに対して解析をかけてボトルネックを探索するhttps://github.com/tkuchiki/alp
	wget https://github.com/tkuchiki/alp/releases/download/v0.3.1/alp_linux_amd64.zip
	unzip alp_linux_amd64.zip -d $(HOME)/dotfiles/bin
	rm alp_linux_amd64.zip

install-peco: # 業務効率化のツール
	wget https://github.com/peco/peco/releases/download/v0.5.1/peco_linux_arm.tar.gz
	tar -xzf peco_linux_arm.tar.gz
	rm peco_linux_arm.tar.gz
	mv ./peco_linux_arm/peco $(HOME)/dotfiles/bin

install-fzf: #業務効率化のツール
	wget https://github.com/junegunn/fzf-bin/releases/download/0.17.1/fzf-0.17.1-linux_amd64.tgz
	tar -xzf fzf-0.17.1-linux_amd64.tgz
	rm fzf-0.17.1-linux_amd64.tgz
	chmod +x ./fzf
	mv ./fzf $(HOME)/dotfiles/bin

install-nodebrew: # nodejsのパッケージマネージャ
	chmod +x $(HOME)/dotfiles/scripts/install-node.sh
	$(HOME)/dotfiles/scripts/install-node.sh $(NODE_VERSION)

install-tmux: # tmuxのinstall
	chmod +x $(HOME)/dotfiles/install_tmux.sh
	$(HOME)/dotfiles/install_tmux.sh

install-dstat: # dstatのinstall ロードアベレージとcpuがkernelなのかuserなのかを見る
	wget https://github.com/dagwieers/dstat/archive/0.7.3.tar.gz
	tar xzf 0.7.3.tar.gz
	mv dstat-0.7.3/dstat $(HOME)/dotfiles/bin

install-htop: # グラフィカルなtop
	wget http://hisham.hm/htop/releases/2.0.0/htop-2.0.0.tar.gz
	tar xzvf htop-2.0.0.tar.gz
	cd htop-2.0.0 && ./configure && make && sudo make install
	rm -rf htop-2.0.0.tar.gz
	rm -rf htop-2.0.0

install-brews: # 最低限必要なものメモ
	brew update
	brew upgrade
	brew install ag
	brew install ctags
	brew install jq
	brew install reattach-to-user-namespace
	brew install tig
	brew install tmux
	brew install tree
	brew install wget
	brew install zsh
	brew install htop
	# フォント
	brew cask install font-myrica
	brew cask install font-myricam
	# Remove outdated versions
	brew cleanup

install-memcached-tool: # memcacheの中身を吐き出すためのツール
	git clone https://github.com/memcached/memcached.git $(HOME)/dotfiles/bin/memcached
	cp $(HOME)/dotfiles/bin/memcached/scripts/* $(HOME)/dotfiles/bin/

pprof: # goのpprofを使ってログ解析
	go tool pprof -seconds=60 /home/isucon/private_isu/webapp/golang/app http://127.0.0.1:6060/debug/pprof/profile

profile-app: # profileを開始する
	go tool pprof /home/isucon/webapp/go/isuda $(APP_LOG)

watch-mysql: # mysqlのプロファイルを行う
	myprofiler -host=localhost -user=$(DB_USER) -password=$(DB_PASS)

watch-nginx-error: # ログファイルの監視 環境変数 設定
	sudo tail -f $(NGINX_ERROR_LOG)

watch-mysql-error: # ログファイルの監視 環境変数 設定
	sudo tail -f $(MYSQL_ERROR_LOG)

watch-top: # グラフィカルなtopを実行
	htop

watch-dstat-io: # dstatでioの原因を探る--top-ioは最もIOが多いプロセスを表示し、--top-bioは最もブロックIOが多いプロセスを表示する。また、一般ユーザでは他ユーザのプロセスなどを取得できないので、sudoをつけて実行するとよい。もちろんPIDを知りたい時は--top-cpu-advと同じように--top-io-adv、--top-bio-adv
	sudo dstat -ta --top-io-adv --top-bio-adv

check-file-disc-capacity-df: #ファイルシステムの容量確認は df コマンドを使います。-T をつけると、ファイルシステムの種別を確認できます。-h をつけると、サイズ表記がヒューマンリーダブルになります。
	df -Th

check-server-time-by-uptime:#サーバが前回再起動してから現在までの稼働している時間をみれます
	uptime

check-dbsize-database-mysql-sql: #テーブルにある容量を確認してindexが効きそうなものを探す
	mysql -u$(DB_USER) -p$(DB_PASS) < $(TOOLS_DIR)/sql/datasize.sql

check-cachehit-cahce-mysql-sql: #キャッシュがしっかり機能しているのかを確認して TODO どう対処するのか?
	mysql -u$(DB_USER) -p$(DB_PASS) < $(TOOLS_DIR)/sql/cachehit.sql

check-disk-io-with-5sec-interval: # ディスクI/O状況を確認できます。-d でインターバルを指定できます。だいたい5秒にしています。ファイルシステムのバッファフラッシュによるバーストがあり、ゆらぎが大きいので、小さくしすぎないことが重要かもしれません。
	iostat -dx 5

check-ps-process: #子プロセス付きでプロセスを見る
	ps -awfx

check-netstat-tcp: #netstat はネットワークに関するさまざまな情報をみれます。 TCPの通信状況をみるのによく使っています-t でTCPの接続情報を表示し、 -n で名前解決せずIPアドレスで表示します。-n がないと連続して名前解決が走る可能性があり、接続が大量な状況だとつまって表示が遅いということがありえます。
	netstat -tnl

check-netstat-all: #TCPの全部のステートをみるには -a を指定します。 -o はTCP接続のタイマー情報、 -pはプロセス名の表示 (-p には root権限が必要) ができます。linuxだた -tanop
	sudo netstat -tanop

check-top-with-process-name: #-c をつけると、プロセスリスト欄に表示されるプロセス名が引数の情報も入ります。気になるプロセスを見つけたら調査idはidleの略
	top -c

check-profile-mysql-pt-query-digest: #pt-query-digestで遅いクエリを解析
	sudo pt-query-digest  $(MYSQL_SLOW_LOG) > $(HOME)/mysql_profile.log

check-profile-nginx-alp: #pt-query-digestでどのルーティングからのアクセスが遅いか調査
	sudo alp -f $(NGINX_ACCESS_LOG) --aggregates "/keyword/\.*" > $(HOME)/nginx_profile.log


check-search-log-file-lsof: #/etcをみてもわからんというときは最終手段で、lsofを使います。 ps や top でログをみたいプロセスのプロセスIDを調べて、lsof -p <pid> を打ちます。 そのプロセスが開いたファイルディスクリプタ情報がみえるので、ログを書き込むためにファイルを開いていれば、出力からログのファイルパスがわかります。
	lsof

check-current-login-user-w: #pcに入っているユーザを確認
	w

# restartさせるserviceの追加
restart: restart-mysql restart-nginx

restart-mysql: #再起動させるコマンド
	sudo /etc/init.d/mysql restart

restart-nginx: #再起動させるコマンド
	sudo /etc/init.d/nginx restart

restart-postgresql: # 再起動させるコマンド
	sudo /etc/init.d/postgresql restart

# TODO 最初の一回だけのものを保持する
backup-mysql: #mysqlのバックアップ
	mysqldump -u $(DB_USER) -p$(DB_PASS)  > $(BACKUP_SQLS)/$(DB_NAME).sql

backup-mysql-all: #システムなど全てのデータをバックアップ
	mysqldump -u root -x --all-databases > $(BACKUP_SQLS)/full_backup.sql

# backup-postgresql:
# 	pg_dump isuconp > backup_psql.sql

# restoreさせるdata storeの選択
restore: restore-mysql

restore-mysql: # mysqlのクエリを実行してリストア
	mysql -u $(DB_USER) -p($DB_PASS) < $(DB_NAME).sql

restore-mysql-all: # mysqlの全てのデータをリストあ
	mysql -u root < $(BACKUP_SQLS)/full_backup.sql

dump-memcache: # memcacheの中身を取得
	memcached-tool localhost:11211 dump

dump-tcpdump: # wiresharkで解析するためのデータを取得
	sudo tcpdump -A port 8080

.PHONY: log
