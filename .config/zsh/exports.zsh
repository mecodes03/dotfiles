#!/bin/sh

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export TZ='Asia/Kolkata'

HISTSIZE=100000
SAVEHIST=100000

export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="kitty"
export BROWSER="brave"
export MANPAGER='nvim +Man!'
export MANWIDTH=999

export BUN_INSTALL="$HOME/.bun"

export PATH="$HOME/.local/bin":$PATH
export PATH="$HOME/.fzf/bin:$PATH"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:$HOME/.local/scripts/"
export PATH="$PATH:/mnt/c/Windows/System32/"
export PATH="$PATH:/mnt/c/Windows/System32/WindowsPowerShell/v1.0"
export PATH="$PATH:/home/mecodes/.local/share/coursier/bin"
