#!/usr/bin/env zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# measure startup time
# zmodload zsh/zprof

[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"


# history
HISTFILE=~/.zsh_history

# allow typing a directory path to change into it
setopt AUTO_CD

# back to insert
export VI_MODE_ESC_INSERT="jk" # place before loading zap-zsh/vim

# source
plug "$HOME/.config/zsh/aliases.zsh"
plug "$HOME/.config/zsh/exports.zsh"
plug "$HOME/.config/zsh/functions.zsh"

# plugins
plug "hlissner/zsh-autopair"
plug "zap-zsh/vim"
plug "Aloxaf/fzf-tab"
plug "romkatv/powerlevel10k"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
plug "zsh-users/zsh-history-substring-search"
plug "romkatv/zsh-defer"

# keybinds
bindkey '^y' autosuggest-accept
bindkey '^k' history-substring-search-up
bindkey '^j' history-substring-search-down
bindkey -M vicmd '^k' history-substring-search-up
bindkey -M vicmd '^j' history-substring-search-down

autoload -Uz compinit
zsh-defer compinit -C  # runs compinit after shell is interactive

# bun completions
[ -s "/home/mecodes/.bun/_bun" ] && source "/home/mecodes/.bun/_bun"

# pnpm
export PNPM_HOME="/home/mecodes/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Rust
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# fnm
FNM_PATH="/home/mecodes/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "$(fnm env --use-on-cd --shell zsh)"
fi

# Added by flyctl installer
export FLYCTL_INSTALL="/home/mecodes/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

# determines search program for fzf
if type ag &> /dev/null; then
    export FZF_DEFAULT_COMMAND='ag -p ~/.gitignore -g ""'
fi

#refer rg over ag
if type rg &> /dev/null; then
    export FZF_DEFAULT_COMMAND='rg --files --hidden'
fi

# fzf
command -v fzf &>/dev/null && eval "$(fzf --zsh)"
# zoxide (replaces cd)
command -v zoxide &>/dev/null && eval "$(zoxide init --cmd cd zsh)"


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Added by Antigravity CLI installer
export PATH="/home/harsh/.local/bin:$PATH"

# kimi-code
export PATH="/home/harsh/.kimi-code/bin:$PATH"

# grok
export PATH="$HOME/.grok/bin:$PATH"

export NVM_DIR="$HOME/.nvm" # this doesn't hurt
######## LAZY LOAD NVM TO REDUCE STARTUP TIME ########
_lazy_nvm() {
  unset -f nvm node npm npx
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}

zsh-defer _lazy_nvm -C

## BENCHMARK
# zprof
