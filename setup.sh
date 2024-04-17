set -e

cd $HOME

if [ ! -d "$HOME/nvim-linux64" ]
then
    wget https://github.com/neovim/neovim/releases/download/v0.9.1/nvim-linux64.tar.gz -O nvim-linux64.tar.gz
    tar -xf nvim-linux64.tar.gz
fi

sudo apt install -y gnome-control-center

sudo apt install -y npm
sudo apt install -y ripgrep
sudo apt install -y clang-tools
sudo apt install -y cppcheck
sudo apt install -y curl
sudo apt install -y gdebi

sudo apt install -y python-is-python3
sudo apt install -y python3-pip
sudo apt install -y python3.10-venv

sudo apt install -y graphviz

pip install cpplint
pip install ruff
pip install mypy

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Go
wget https://go.dev/dl/go1.21.0.linux-amd64.tar.gz -O go.tar.gz
if [ -d "/usr/local/go" ]
then
    sudo rm -rf /usr/local/go
fi
tar -xzf go.tar.gz
sudo mv go /usr/local

## golang linter
go install github.com/mgechev/revive@latest

# Java
sudo apt install -y openjdk-17-jdk openjdk-17-jre

# Nerd Font
sudo apt install -y unzip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/UbuntuMono.zip -O UbuntuMono.zip
sudo unzip UbuntuMono.zip -d /usr/share/fonts
fc-cache -fv /usr/share/fonts

# Rust test runner
curl -LsSf https://get.nexte.st/latest/linux | tar zxf - -C ${CARGO_HOME:-~/.cargo}/bin

# Idris2
sudo apt install libgmp3-dev chezscheme
git clone https://github.com/idris-lang/Idris2.git
cd ./Idris2
make bootstrap SCHEME=chezscheme
make install
cd ..

bash -c "$(curl -fsSL https://raw.githubusercontent.com/stefan-hoeck/idris2-pack/main/install.bash)"

pack install-app idris2-lsp

# tmux
sudo apt install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# deno
curl -fsSL https://deno.land/x/install/install.sh | sh
source ~/.bashrc

# tree-sitter-cli
cargo install tree-sitter-cli

# protobufs
sudo apt install protobuf-compiler

## protobuf lsp
git clone git@github.com:pbkit/pbkit.git
deno install -n pb -A --unstable pbkit/cli/pb/entrypoint.ts

# zhs
sudo apt install zsh
sudo apt install zsh-syntax-highlighting

# clipboard for vim
sudo apt install xclip

# [nvim] 
## venv-selector
sudo apt install fd-find

## lua
sudo apt install luarocks

cargo install ast-grep

sudo apt install cscope

