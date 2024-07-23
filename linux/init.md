# Fresh Installation

## STEPS

- sudo apt update
- sudo apt install build-essential
- sudo apt install unzip
- sudo apt install zsh

- Changing default shell:
	- chsh <CR>
	- /bin/zsh

- /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
- vim .zshrc
	- export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"

- sudo apt install python3 python3-pip
- ln -s /usr/bin/python3.12 /usr/bin/python
- ln -s /usr/bin/pip3 /usr/bin/pip3
- To install python global dependencies you can do -> sudo apt install python3-xyz

- curl -fsSL https://fnm.vercel.app/install | bash
- vim .zshrc
- #fnm
  FNM_PATH="/home/batmi/.local/share/fnm"
  if [ -d "$FNM_PATH" ]; then
    export PATH="$FNM_PATH:$PATH"
    eval "`fnm env`"
  fi
- source .zshrc
- fnm use --install-if-missing 22

- curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
- vim .zshrc
	- export PATH="$HOME/cargo/bin:$PATH"
- wget https://go.dev/dl/go1.22.5.linux-amd64.tar.gz
- tar -xzf go1.22.5.linux-amd64.tar.gz
- mv go /usr/local/
- vim .zshrc
	- export PATH="/usr/local/go/bin:$PATH"
- rm go1.22.5.linux-amd64.tar.gz

- wget https://ziglang.org/builds/zig-linux-x86_64-0.14.0-dev.244+0d79aa017.tar.xz
- tar -xf zig-linux-x86_64-0.14.0-dev.244+0d79aa017.tar.xz
- rm zig-linux-x86_64-0.14.0-dev.244+0d79aa017.tar.xz
- mv zig-linux-x86_64-0.14.0-dev.244+0d79aa017 /usr/local/zig
- vim .zshrc
	- export PATH="/usr/local/zig:$PATH"



- rm .bash_logout .bashrc
