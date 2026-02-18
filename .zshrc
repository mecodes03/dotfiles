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


# If argument is unknown but is name of a directory, cd into it
setopt autocd
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# FZF-tab with optimized settings
zinit light Aloxaf/fzf-tab
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'

# Optimized plugin loading
zinit wait lucid for \
  atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
  zdharma-continuum/fast-syntax-highlighting \
  blockf \
  zsh-users/zsh-completions \
  atload"_zsh_autosuggest_start; \
      ZSH_AUTOSUGGEST_STRATEGY=(history completion) \
      ZSH_AUTOSUGGEST_MANUAL_REBIND=0 \
      ZSH_AUTOSUGGEST_HISTORY_IGNORE=' *' \
      bindkey '^k' history-search-backward; \
      bindkey '^j' history-search-forward; \
      bindkey '^y' autosuggest-accept; \
      bindkey '^e' autosuggest-execute; \
      bindkey '^a' autosuggest-toggle; \
      bindkey '^s' autosuggest-clear" \
  zsh-users/zsh-autosuggestions

# Git plugin from Oh My Zsh - loaded when entering a git repository (Lazy Loading)
zinit ice wait lucid
zinit snippet OMZP::git

# Load Node version manager only when needed
# export NVM_LAZY_LOAD=true
# export NVM_COMPLETION=true
# zinit ice wait lucid
# zinit light lukechilds/zsh-nvm

zinit cdreplay -q

# Load completions
autoload -Uz compinit

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase

# Key bindings
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

# PATHS : ---------------------------------------------------------------------
# neoviim path
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
# rust
. "$HOME/.cargo/env"
# Go
export PATH=$PATH:/usr/local/go/bin
# solana
export PATH="/home/mecodes/.local/share/solana/install/active_release/bin:$PATH"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Nodejs Version Manager
export NVM_DIR="$HOME/.nvm"
# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
# fzf
export PATH="$HOME/.fzf/bin:$PATH"
# zoxide
export PATH="$HOME/.local/bin:$PATH"
# local scripts
PATH="$PATH":"$HOME/.local/scripts/"


# Aliases
alias ls="eza"
alias lsa="eza -la"
alias rmrf='rm -rf'
alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"
alias python="python3"
alias d="cd /mnt/d"
alias c="cd /mnt/c"
alias k="kubectl"
alias vim="nvim"
alias wsl="/mnt/c/Windows/wsl.exe"
alias terminate="wsl --terminate Ubuntu-24.04"
alias winsetting="nvim /mnt/c/Users/HP/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"
alias bat="batcat"

# Integrations (only if commands exist to avoid errors)
command -v fzf >/dev/null 2>&1 && source <(fzf --zsh)
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init --cmd cd zsh)"

# Load p10k config
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
