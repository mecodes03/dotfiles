# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/ Load init
source "${ZINIT_HOME}/zinit.zsh"

# Set language/locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Set TimeZone
export TZ='Asia/Kolkata'

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# PATHS : ---------------------------------------------------------------------
# rust
. "$HOME/.cargo/env"

# Go
export PATH=$PATH:/usr/local/go/bin

# solana
export PATH="/home/mecodes/.local/share/solana/install/active_release/bin:$PATH"

# neoviim path
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# bun completions
[ -s "/home/mecodes/.bun/_bun" ] && source "/home/mecodes/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# fzf
export PATH="$HOME/.fzf/bin:$PATH"

#zoxide
export PATH="$HOME/.local/bin:$PATH"

# local scripts
PATH="$PATH":"$HOME/.local/scripts/"

# PATHS END : ---------------------------------------------------------------------

# If argument is unknown but is name of a directory, cd into it
setopt autocd

# Try to correct spelling of mistyped commands
setopt correct

# Add in Zsh Plugins
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# bind ctrl-y
bindkey '^y' autosuggest-accept

# going forward and backword
bindkey '^k' history-search-backward
bindkey '^j' history-search-forward

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Aa-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no

# fzf-tab configuration
zstyle ':fzf-tab:*' fzf-flags \
  --preview-window=right:65%:wrap \
  --height=50% \
  --bind 'ctrl-/:toggle-preview'

# Directory preview
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -a --color=always $realpath'

# File preview with bat
zstyle ':fzf-tab:complete:*:*' fzf-preview \
  'if [[ -d $realpath ]]; then
    ls -a --color=always $realpath
  elif [[ -f $realpath ]]; then
    bat --color=always --style=numbers --line-range=:500 $realpath 2>/dev/null || cat $realpath
  fi'

# ALIASES
alias ls='ls --color'
alias lsa='ls -la'
alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"

alias d="cd /mnt/d"
alias c="cd /mnt/c"

alias k="kubectl"
alias vim="nvim"
alias wsl="wsl.exe"
alias terminate="wsl --terminate Ubuntu-24.04"
alias winsetting="nvim /mnt/c/Users/HP/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"
alias bat="batcat"

# Add to your .zshrc
bindkey "^[[1;5C" forward-word      # Ctrl+Right
bindkey "^[[1;5D" backward-word     # Ctrl+Left
bindkey "^[[1;5A" up-line-or-history    # Ctrl+Up
bindkey "^[[1;5B" down-line-or-history  # Ctrl+Down


# macro for tmux-sessionizer
tmux-sessionizer-widget() {
    # Clear the current line
    zle reset-prompt

    # Run in a subshell with proper terminal
    BUFFER="tmux-sessionizer"
    zle accept-line
}
zle -N tmux-sessionizer-widget
bindkey '^f' tmux-sessionizer-widget

# open today note
function _note_today() {
  notes -t         # run your script with -t (today)
  zle reset-prompt # refresh the prompt after running
}
zle -N _note_today
bindkey '^n' _note_today

# INTEGRATIONS
# fzf
source <(fzf --zsh)
eval "$(zoxide init --cmd cd zsh)"
