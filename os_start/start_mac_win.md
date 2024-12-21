# LANGUAGES

## Zig

[Download](https://github.com/ziglang/zig/releases)

## Rust

### Windows

[Download](https://static.rust-lang.org/rustup/dist/x86_64-pc-windows-msvc/rustup-init.exe)

### Mac

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

## Python

[Download](https://www.python.org/downloads/)

## Node

[Download](https://nodejs.org/dist/v20.16.0/node-v20.16.0-x64.msi)

## Go

[Download](https://go.dev/dl/)

## Lua

[Download](https://sourceforge.net/projects/luabinaries/files/5.4.2/)

## Gleam - Erlang - Elixir

### Windows

```bash
scoop install erlang
scoop install gleam
scoop install elixir
```

### Mac

```bash
brew install erlang
brew install gleam
brew install elixir
```

## Ocaml - Opam

[Download](https://github.com/ocaml/opam/releases)

# FILE EXPLORER

## Yazi

```bash
cargo install --locked --git https://github.com/sxyazi/yazi.git yazi-fm yazi-cli
```

### Windows

- Add environment variable
  `YAZI_FILE_ONE = "C:\Program Files\Git\usr\bin\file.exe"`

### Mac

```bash
brew install font-symbols-only-nerd-font
brew install ffmpegthumbnailer
```

Optional Dependencies:

- [poppler](#poppler)
- [ripgrep](#ripgrep)
- [fzf](#fzf)
- [zoxide](#zoxide)
- [fd](#fd)
- [jq](#jq)
- [unar](#unar)
- [delta](#delta)
- [sad](#sad)

# TOOLS

## Lazygit

```bash
go install github.com/jesseduffield/lazygit@latest
```

## poppler

### Windows

```bash
scoop install poppler
```

### Mac

```bash
brew install poppler
```

## ripgrep

```bash
cargo install ripgrep
```

## fzf

### Mac

```bash
brew install fzf
```

### Windows

```bash
scoop install fzf
```

## zoxide

```bash
cargo install zoxide --locked
```

## bat - cat replacement

### Mac

```bash
brew install bat
```

### Windows

```bash
scoop install bat
```

## fd

### Mac

```bash
brew install fd
```

### Windows

```bash
scoop install fd
```

## lsd

### Mac

```bash
brew install lsd
```

### Windows

```bash
cargo install lsd
```

## jq

[link](https://jqlang.github.io/jq/)

## bottom

```bash
cargo install bottom --locked
```

## unar

[UNAR](https://theunarchiver.com/command-line)

## cmake

### Windows

[CMAKE](https://cmake.org/download/)

## make

### Windows

```bash
choco install make
```

## LLVM + Clang

### Windows

[LLVM + CLANG](https://github.com/llvm/llvm-project/releases)

## Delta

```bash
cargo install git-delta
```

# NEOVIM

### Mac

```bash
brew install --HEAD neovim
brew upgrade neovim --fetch-HEAD
```

### Windows

```bash
choco install neovim --pre
```

## NEOVIM DEPENDENCIES

```bash
pip install neovim
npm install -g neovim
```
