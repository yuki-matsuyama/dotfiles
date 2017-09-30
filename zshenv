export PATH=$HOME/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin

# for homebrew
export PATH=/usr/local/opt:/usr/local/bin:$PATH

# for golang
GO_VERSION=$(cat $HOME/.anyenv/envs/goenv/version)
export GOROOT=$HOME/.anyenv/envs/goenv/versions/$GO_VERSION
export GOPATH=$HOME/dev
export PATH=$HOME/.anyenv/envs/goenv/shims/bin:$PATH
export PATH=$GOPATH/bin:$PATH

# for rust
export PATH=$HOME/.cargo/bin:$PATH
export RUST_SRC_PATH=$HOME/rust-src/rustc-1.12.0/src

# for heroku
export PATH=$PATH:/usr/local/heroku/bin

# for terraform
export PATH=$PATH:$HOME/.terraform
export PATH=$PATH:/usr/local/terraform

# for packer
export PATH=/usr/local/packer:$PATH

# for terraform
export PATH=/usr/local/terraform:$PATH

# neovim
export XDG_CONFIG_HOME=~/.config

export OZHOME=$HOME/works/haroid/platform

# for chef-gem
export PATH=$PATH:$HOME/.chefdk/gem/ruby/2.1.0/bin
