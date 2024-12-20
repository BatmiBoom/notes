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
# chs /usr/bin/pwsh

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

# NVIM
sudo apt-get install python3-neovim
sudo apt-get install python3-venv
sudo snap install --edge nvim --classic
