#!bin/sh
VERSION_ID="22.04"
# Update Everything
sudo apt update
sudo apt upgrade

# Essentials
sudo apt install build-essential
sudo apt install unzip
sudo apt install bubblewrap

# Powershell

## INSTALL
sudo apt install -y wget apt-transport-https software-properties-common
wget -q https://packages.microsoft.com/config/ubuntu/$VERSION_ID/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
sudo apt update
sudo apt install -y powershell
# chs /usr/bin/pwsh If using default shell

# Cmake
sudo snap install cmakel

# Git
sudo apt install git

# GH
sudo apt install gh
gh auth login
gh config set -h github.com git_protocol ssh

# Python
sudo apt install python3
sudo apt install python3-pip
sudo ln -s /usr/bin/python3 /usr/bin/python

# Node
sudo apt install nodejs
sudo apt install npm
npm install -g neovim

# Go
sudo apt install golang-go

# Rust
curl --proto '=https' --tlsv1.3 https://sh.rustup.rs -sSf | sh

# Zig

sudo snap install zig --classic --beta

# Lua
sudo apt install lua5.4
 
# Erlang
sudo add-apt-repository ppa:rabbitmq/rabbitmq-erlang
sudo apt update
sudo apt install erlang-dev erlang-xmerl

# Elixit
sudo apt install elixir

# Gleam
cd /tmp & git clone https://github.com/gleam-lang/gleam.git & cd gleam & make install & mv target/release/gleam /usr/loca/bin

# Ocaml
bash -c "sh <(curl -fsSL https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh)"
opam init

# FILE EXPLORER

## Yazi
cargo install --locked --git https://github.com/sxyazi/yazi.git yazi-fm yazi-cli

# TOOLS

## Lazygit
go install github.com/jesseduffield/lazygit@latest

## poppler
scoop install poppler

## ripgrep
cargo install ripgrep

## fzf
sudo apt-get install fzf

## zoxide
cargo install zoxide --locked

## bat - cat replacement

### Linux
sudo apt install bat

## fd

### Linux
sudo apt install fd-find
ln -s $(which fdfind) ~/.local/bin/fd


## lsd
sudo apt install lsd

## jq

wget https://github.com/jqlang/jq/releases/download/jq-1.7.1/jq-linux-amd64
tar -C /usr/local/bin -xvf jq-linux-amd64
chmod +x jq-linux-amd64
mv jq-linux-amd64 /usr/local/bin/jq

## bottom

```bash
cargo install bottom --locked
```

## cmake
sudo apt install cmake

## LLVM + Clang
sudo apt-get install clang-format clang-tidy clang-tools clang clangd libc++-dev libc++1 libc++abi-dev libc++abi1 libclang-dev libclang1 liblldb-dev libllvm-ocaml-dev libomp-dev libomp5 lld lldb llvm-dev llvm-runtime llvm python3-clang

## Delta
cargo install git-delta

# NVIM
sudo apt-get install python3-neovim
sudo apt-get install python3-venv
sudo snap install --edge nvim --classic

# profile.ps1
$env:LANG="en_US.UTF-8"
$env:EDITOR="nvim"

$env:DEV_MODE = "BRAINHI"

$env:PATH+=":$HOME/bin:/usr/local/bin"

# NODE PATH
$env:PATH+=":/usr/local/bin/node"
$env:PATH+=":/usr/local/bin/npm"

# NIM Path
$env:PATH+=":$HOME/.nimble/bin"

# Python dep
$env:PYENV_ROOT="$HOME/.pyenv"
$env:PATH+=":$HOME/.pyenv/bin"
$env:PATH+=":$HOME/.pyenv/versions/3.9.20/bin"
$env:PATH+=":$HOME/.pyenv/shims"

# LSP SERVERS

# ZIG
$env:PATH+=":$HOME/.local/zig"

# ODIN
$env:PATH+=":$HOME/.odin"
$env:PATH+=":$HOME/.ols"

# GO
$env:PATH+=":/usr/local/go/bin"

# CARGO
$env:PATH+=":$HOME/.cargo/bin"
$env:PATH+=":$HOME/.cargo/env"

# ODIN
$env:PATH+=":$HOME/odin"
$env:PATH+=":$HOME/ols"

# LOCAL
$env:PATH+=":$HOME/.local/bin"

# MANPATH
$env:MANPATH=":/usr/local/man"

# MASON
$env:PATH+=":$HOME/.local/share/nvim/mason/bin"

# DENO
$env:PATH+=":$HOME/.deno/bin"

# LIBPQ
$env:DOCKER_DEFAULT_PLATFORM="linux/amd64"

function reload-powershell {
  . $PROFILE
  . /home/batmi/.config/powershell/profile.ps1
}

function reset_nvim {
   rm -rf ~/.local/share/nvim && rm -rf ~/.local/state/nvim && rm -rf ~/.cache/nvim
}
