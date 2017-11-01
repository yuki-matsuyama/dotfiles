link:
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
	cat $(HOME)/dotfiles/env.sh >> bashrc
	cat $(HOME)/dotfiles/env.sh >> zshrc

install-anyenv:
	if [ -d "~/.anyenv" ]; then \
		git clone https://github.com/riywo/anyenv ~/.anyenv; \
	fi
	chmod +x anyenv.sh
	./anyenv.sh

install-anyenvs:
	anyenv install rbenv
	anyenv install plenv
	anyenv install pyenv
	anyenv install ndenv
	anyenv install phpenv
	anyenv install luaenv
	anyenv install goenv
	exec $SHELL -l
	rbenv install 2.4.0
	plenv install 5.25.9
	pyenv install 2.7.13
	pyenv install 2.7.9
	pyenv install 3.6.0
	ndenv install 6.9.4
	goenv install 1.8
	phpenv install 7.0.2
	rbenv global 2.4.0
	plenv global 5.25.9
	phpenv global 7.0.2
	pyenv global 2.7.9
	pyenv global 3.6.0
	ndenv global 6.9.4
	goenv global 1.8
	rbenv rehash 2.4.0
	plenv rehash 5.25.9
	phpenv rehash 7.0.2
	pyenv rehash 2.7.9
	pyenv rehash 3.6.0
	ndenv rehash 6.9.4
	goenv rehash 1.8

install-cloudtool:
	wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-170.0.1-darwin-x86_64.tar.gz
	tar -xzf google-cloud-sdk-170.0.1-darwin-x86_64.tar.gz
	./google-cloud-sdk/install.sh
	./google-cloud-sdk/bin/gcloud init
	./google-cloud-sdk/bin/gcloud components install app-engine-go
	chmod -R +x ./google-cloud-sdk/platform/google_appengine/

install-tmux-reahat:
	sudo yum install tmux

install-tmux-debian:
	sudo apt-get install tmux

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

install-brews: install-brew
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
	git clone https://github.com/memcached/memcached.git ${HOME}/dotfiles/bin/memcached
	cp ${HOME}/dotfiles/bin/memcached/scripts/* ${HOME}/dotfiles/bin/
go:
	# direnv
	# glide
	# dep
	#
#TODO
make-keys:

prebench:
	chmod +x $(HOME)/dotfiles/prebench.sh
	$(HOME)/dotfiles/prebench.sh

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
	go tool pprof /home/isucon/webapp/go/isuda ${APP_LOG}

watch-mysql:
	myprofiler -host=localhost -user=${DB_USER} -password=${DB_PASS}

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
	mysql -u${DB_USER} -p${DB_PASS} < ${TOOLS_DIR}/sql/dbsize.sql

check-cachehit:
	mysql -u${DB_USER} -p${DB_PASS} < ${TOOLS_DIR}/sql/cachehit.sql

check-ps:
	ps -aufx

check-tcp:
	netstat -tnl

profile-mysql:
	sudo pt-query-digest  ${MYSQL_SLOW_LOG} > ${HOME}/mysql_profile.log

profile-nginx:
	sudo alp -f ${NGINX_ACCESS_LOG} --aggregates "/keyword/\.*" > ${HOME}/nginx_profile.log

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
	mysqldump -u ${DB_USER} -p${DB_PASS}  > ${DB_NAME}.sql

backup-mysql-all:
	mysqldump -u root -x --all-databases > full_backup.sql

# backup-postgresql:
# 	pg_dump isuconp > backup_psql.sql

# restoreさせるdata storeの選択
restore: restore-mysql

restore-mysql:
	mysql -u ${DB_USER} -p{$DB_PASS} < ${DATABASE}.sql

restore-mysql-all:
	mysql -u root < full_backup.sql

dump-memcache:
	memcached-tool localhost:11211 dump

dump-tcpdump:
	sudo tcpdump -A port 8080

# retore-psql:
# 	psql restore < backup_psql.sql

.PHONY: log
