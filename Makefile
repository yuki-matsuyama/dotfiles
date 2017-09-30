link:
	ln -sf $(HOME)/dotfiles/editorconfig $(HOME)/.editorconfig
	ln -sf $(HOME)/dotfiles/gemrc $(HOME)/.gemrc
	ln -sf $(HOME)/dotfiles/gvimrc $(HOME)/.gvimrc
	ln -sf $(HOME)/dotfiles/tigrc $(HOME)/.tigrc
	ln -sf $(HOME)/dotfiles/tmux.conf $(HOME)/.tmux.conf
	ln -sf $(HOME)/dotfiles/vim $(HOME)/.vim
	ln -sf $(HOME)/dotfiles/vimrc $(HOME)/.vimrc
	ln -sf $(HOME)/dotfiles/zshenv $(HOME)/.zshenv
	ln -sf $(HOME)/dotfiles/zshrc $(HOME)/.zshrc

anyenv:
	git clone https://github.com/riywo/anyenv ~/.anyenv
	exec $(SHELL) -l
	anyenv install rbenv
	anyenv install plenv
	anyenv install pyenv
	anyenv install ndenv
	anyenv install luaenv
	anyenv install goenv
	rbenv install 2.4.0
	plenv install 5.25.9
	pyenv install 2.7.13
	pyenv install 3.6.0
	ndenv install 6.9.4
	goenv install 1.8

setup:
	# homebrew
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	# zplug
	curl -sL zplug.sh/installer | zsh
	# prezto
	git clone --recursive https://github.com/sorin-ionescu/prezto.git "${HOME}/.zprezto"
	setopt EXTENDED_GLOB
	for rcfile in "${HOME}"/.zprezto/runcoms/^README.md(.N); do
	  ln -s "$rcfile" "${HOME}/.${rcfile:t}"
	done
	# current shell
	chsh -s /bin/zsh

brew:
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
	# フォント
	brew cask install font-myrica
	brew cask install font-myricam
	# Remove outdated versions
	brew cleanup

go:
	# direnv
	# glide
	# dep
	#



.PHONY: link
