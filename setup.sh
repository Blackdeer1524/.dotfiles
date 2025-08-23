set -e

cd $HOME

if [ ! -d "$HOME/nvim-linux64" ]
then
    wget https://github.com/neovim/neovim/releases/download/v0.10.1/nvim-linux64.tar.gz -O nvim-linux64.tar.gz
    tar -xf nvim-linux64.tar.gz
fi

sudo apt install -y gnome-control-center npm ripgrep clang-tools \
    cppcheck curl gdebi python-is-python3 python3-pip python3.12-venv graphviz

# pip install cpplint
# pip install ruff
# pip install mypy

# zhs
sudo apt install -y zsh
sudo apt install -y zsh-syntax-highlighting

# clipboard for vim
sudo apt install -y xclip

# OCR
sudo apt install -y yad scrot imagemagick xsel sox tesseract-ocr tesseract-ocr-rus 

# Anki fix
sudo apt install -y libxcb-cursor0

# Nerd Font
sudo apt install -y unzip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Hasklig.zip -O Hasklig.zip
sudo unzip Hasklig.zip -d /usr/share/fonts
fc-cache -fv /usr/share/fonts

# Rust
# WARN: INSTALL HIDDIFY FIRST
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

## Rust test runner
curl -LsSf https://get.nexte.st/latest/linux | tar zxf - -C ${CARGO_HOME:-~/.cargo}/bin

# alacritty
sudo apt -y install cmake g++ pkg-config libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3

if [ ! -d "$HOME/alacritty" ]
then
    git clone https://github.com/alacritty/alacritty.git
fi
cd alacritty
git pull
cargo build --release

infocmp alacritty && sudo tic -xe alacritty,alacritty-direct extra/alacritty.info
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database

sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator $(which alacritty) 50

# tmux
sudo apt install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Go
wget https://go.dev/dl/go1.24.0.linux-amd64.tar.gz -O go.tar.gz
if [ -d "/usr/local/go" ]
then
    sudo rm -rf /usr/local/go
fi
tar -xzf go.tar.gz
sudo mv go /usr/local

## golang linter
go install github.com/mgechev/revive@latest

# binary will be $(go env GOPATH)/bin/golangci-lint
curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/HEAD/install.sh | sh -s -- -b $(go env GOPATH)/bin v2.3.0

golangci-lint --version

# Syncthing
sudo mkdir -p /etc/apt/keyrings
sudo curl -L -o /etc/apt/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg
echo "deb [signed-by=/etc/apt/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list
sudo apt-get update
sudo apt-get install -y syncthing

# Java
sudo apt install -y openjdk-17-jdk openjdk-17-jre

# Idris2
sudo apt install libgmp3-dev chezscheme
git clone https://github.com/idris-lang/Idris2.git
cd ./Idris2
make bootstrap SCHEME=chezscheme
make install
cd ..

bash -c "$(curl -fsSL https://raw.githubusercontent.com/stefan-hoeck/idris2-pack/main/install.bash)"

pack install-app idris2-lsp

# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# deno
curl -fsSL https://deno.land/x/install/install.sh | sh
source ~/.bashrc

# protobufs
sudo apt install protobuf-compiler

## protobuf lsp
git clone git@github.com:pbkit/pbkit.git
deno install -n pb -A --unstable pbkit/cli/pb/entrypoint.ts

# [nvim] 
# tree-sitter-cli
cargo install tree-sitter-cli

## venv-selector
sudo apt install fd-find

## lua
sudo apt install luarocks

cargo install ast-grep

sudo apt install cscope

# AppImage

sudo add-apt-repository universe
sudo apt install -y libfuse2t64

