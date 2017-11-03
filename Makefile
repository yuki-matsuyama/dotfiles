TOOLS_DIR=$(HOME)/dotfiles
NGINX_ACCESS_LOG='/var/log/nginx/access_log'
NGINX_ERROR_LOG='/var/log/nginx/error_log'
MYSQL_SLOW_LOG='/var/log/mysql/'
MYSQL_ERROR_LOG="/var/log/mysql/mysql_error_log"
BACKUP_SQLS='$(HOME)/dotfiles/sql/backup'
DB_USER='isucon'
DB_PASS='isucon'
DB_NAME='isucon'
RUBY_VERSION='2.4.0'
GO_VERSION='1.8'
PHP_VERSION='7.0.2'
NODE_VERSION='8.7.0'
PERL_VERSION='5.25.9'
PYTHON_VERSION='3.6.0'
PLATFORM='Darwin'

link:
	chmod +x $(HOME)/dotfiles/scripts/prelink.sh
	$(HOME)/dotfiles/scripts/prelink.sh
	ln -sf $(HOME)/dotfiles/editorconfig $(HOME)/.editorconfig
	ln -sf $(HOME)/dotfiles/gemrc $(HOME)/.gemrc
	ln -sf $(HOME)/dotfiles/gvimrc $(HOME)/.gvimrc
	ln -sf $(HOME)/dotfiles/tigrc $(HOME)/.tigrc
	ln -sf $(HOME)/dotfiles/tmux.conf $(HOME)/.tmux.conf
	ln -sf $(HOME)/dotfiles/vimrc $(HOME)/.vimrc
	ln -sf $(HOME)/dotfiles/zshenv $(HOME)/.zshenv
	# ln -sf $(HOME)/dotfiles/zpreztorc $(HOME)/.zpreztorc
	ln -sf $(HOME)/dotfiles/zshrc $(HOME)/.zshrc
	ln -sf $(HOME)/dotfiles/bashrc $(HOME)/.bashrc
	ln -sf $(HOME)/dotfiles/config/dein $(HOME)/.config/dein
	cat $(HOME)/dotfiles/scripts/env.sh >> bashrc
	cat $(HOME)/dotfiles/scripts/env.sh >> zshrc

install-anyenv:
	if [ ! -d "~/.anyenv" ]; then \
		git clone https://github.com/riywo/anyenv ~/.anyenv; \
		chmod +x $(HOME)/dotfiles/scripts/anyenv.sh
		$(HOME)/dotfiles/scripts/anyenv.sh
	fi

install-anyenvs:
	anyenv install rbenv
	anyenv install plenv
	anyenv install pyenv
	anyenv install ndenv
	anyenv install phpenv
	anyenv install luaenv
	anyenv install goenv
	exec $SHELL -l
	rbenv install $(RUBY_VERSION)
	plenv install $(PERL_VERSION)
	pyenv install 2.7.9
	pyenv install $(PYTHON_VERSION)
	ndenv install $(NODE_VERSION)
	goenv install $(GO_VERSION)
	phpenv install $(PHP_VERSION)
	rbenv global $(RUBY_VERSION)
	plenv global $(PERL_VERSION)
	phpenv global $(PHP_VERSION)
	pyenv global 2.7.9
	pyenv global $(PYTHON_VERSION)
	ndenv global $(NODE_VERSION)
	goenv global $(GO_VERSION)
	rbenv rehash $(RUBY_VERSION)
	plenv rehash $(PERL_VERSION)
	phpenv rehash $(PHP_VERSION)
	pyenv rehash 2.7.9
	pyenv rehash $(PYTHON_VERSION)
	ndenv rehash $(NODE_VERSION)
	goenv rehash $(GO_VERSION)

install-cloudtool:
	wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-170.0.1-darwin-x86_64.tar.gz
	tar -xzf google-cloud-sdk-170.0.1-darwin-x86_64.tar.gz
	./google-cloud-sdk/install.sh
	./google-cloud-sdk/bin/gcloud init
	./google-cloud-sdk/bin/gcloud components install app-engine-go
	chmod -R +x ./google-cloud-sdk/platform/google_appengine/

install-tmux:
	chmod +x $(HOME)/dotfiles/install_tmux.sh
	$(HOME)/dotfiles/install_tmux.sh

install-composer:
	curl -sS https://getcomposer.org/installer | php
	mv composer.phar $(HOME)/dotfiles/bin/composer

install-brew:
	# homebrew
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

install-dstat:
	wget https://github.com/dagwieers/dstat/archive/0.7.3.tar.gz
	tar xzf 0.7.3.tar.gz
	mv dstat-0.7.3/dstat $(HOME)/dotfiles/bin

install-ohmyzsh:
	sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)" && plugins=(git)

install-bashit:
	git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
	sh ~/.bash_it/install.sh

install-htop:
	wget http://hisham.hm/htop/releases/2.0.0/htop-2.0.0.tar.gz
	tar xzvf htop-2.0.0.tar.gz
	cd htop-2.0.0 && ./configure && make && sudo make install
	rm -rf htop-2.0.0

install-brews:
	brew update
	brew upgrade
	brew install ag
	brew install ctags
	brew install direnv
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

install-memcached-tool:
	git clone https://github.com/memcached/memcached.git $(HOME)/dotfiles/bin/memcached
	cp $(HOME)/dotfiles/bin/memcached/scripts/* $(HOME)/dotfiles/bin/

install-npms:
	npm install -g vue-cli
	npm install -g gulp
	npm install -g dockly

go:
	# direnv
	# glide
	# dep
	#
#TODO
make-keys:

prebench:
	chmod +x $(HOME)/dotfiles/scripts/prebench.sh
	$(HOME)/dotfiles/scripts/prebench.sh

journal: journal-mysql journal-nginx

journal-nginx:
	sudo journalctl -f -u nginx

journal-mysql:
	sudo journalctl -f -u mysql

journal-postgresql:
	sudo journalctl -f -u  postgresql

install: install-alp install-myprofiler install-pt-query-digest install-peco install-fzf install-bashit install-ohmyzsh

install-myprofiler:
	wget https://github.com/KLab/myprofiler/releases/download/0.1/myprofiler.linux_amd64.tar.gz
	tar xf myprofiler.linux_amd64.tar.gz -C $(HOME)/dotfiles/bin
	rm myprofiler.linux_amd64.tar.gz

install-pt-query-digest:
	wget percona.com/get/pt-query-digest -P $(HOME)/dotfiles/bin
	chmod +x $(HOME)/dotfiles/bin/pt-query-digest

install-alp:
	wget https://github.com/tkuchiki/alp/releases/download/v0.3.1/alp_linux_amd64.zip
	unzip alp_linux_amd64.zip -d $(HOME)/dotfiles/bin
	rm alp_linux_amd64.zip

install-peco:
	wget https://github.com/peco/peco/releases/download/v0.5.1/peco_linux_arm.tar.gz
	tar -xzf peco_linux_arm.tar.gz
	rm peco_linux_arm.tar.gz
	mv ./peco_linux_arm/peco $(HOME)/dotfiles/bin

install-fzf:
	wget https://github.com/junegunn/fzf-bin/releases/download/0.17.1/fzf-0.17.1-linux_amd64.tgz
	tar -xzf fzf-0.17.1-linux_amd64.tgz
	rm fzf-0.17.1-linux_amd64.tgz
	chmod +x ./fzf
	mv ./fzf $(HOME)/dotfiles/bin

profile: profile-mysql profile-nginx

pprof:
	go tool pprof -seconds=60 /home/isucon/private_isu/webapp/golang/app http://127.0.0.1:6060/debug/pprof/profile

profile-app:
	go tool pprof /home/isucon/webapp/go/isuda $(APP_LOG)

watch-mysql:
	myprofiler -host=localhost -user=$(DB_USER) -password=$(DB_PASS)

watch-nginx-error:
	sudo tail -f $(NGINX_ERROR_LOG)

watch-mysql-error:
	sudo tail -f $(MYSQL_ERROR_LOG)

watch-top:
	htop

watch-dstat:
	dstat

check-fs:
	df -Th

check-dbsize:
	mysql -u$(DB_USER) -p$(DB_PASS) < $(TOOLS_DIR)/sql/dbsize.sql

check-cachehit:
	mysql -u$(DB_USER) -p$(DB_PASS) < $(TOOLS_DIR)/sql/cachehit.sql

check-ps:
	ps -aufx

check-tcp:
	netstat -tnl

profile-mysql:
	sudo pt-query-digest  $(MYSQL_SLOW_LOG) > $(HOME)/mysql_profile.log

profile-nginx:
	sudo alp -f $(NGINX_ACCESS_LOG) --aggregates "/keyword/\.*" > $(HOME)/nginx_profile.log

# restartさせるserviceの追加
restart: restart-mysql restart-nginx

restart-mysql:
	sudo /etc/init.d/mysql restart

restart-nginx:
	sudo /etc/init.d/nginx restart

# restart-postgresql:
# 	sudo /etc/init.d/postgresql restart

# backupするdata storeの選択
backup: backup-mysql

# TODO 最初の一回だけのものを保持する
backup-mysql:
	mysqldump -u $(DB_USER) -p$(DB_PASS)  > $(BACKUP_SQLS)/$(DB_NAME).sql

backup-mysql-all:
	mysqldump -u root -x --all-databases > $(BACKUP_SQLS)/full_backup.sql

# backup-postgresql:
# 	pg_dump isuconp > backup_psql.sql

# restoreさせるdata storeの選択
restore: restore-mysql

restore-mysql:
	mysql -u $(DB_USER) -p($DB_PASS) < $(DB_NAME).sql

restore-mysql-all:
	mysql -u root < $(BACKUP_SQLS)/full_backup.sql

dump-memcache:
	memcached-tool localhost:11211 dump

dump-tcpdump:
	sudo tcpdump -A port 8080

# retore-psql:
# 	psql restore < backup_psql.sql

.PHONY: log
