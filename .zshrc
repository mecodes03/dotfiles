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

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Shell options
setopt autocd
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styles (set before plugins load)
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*:*:java*:*' complete-options true
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:*' switch-group ',' '.'

# Bun completions (must be before compinit)
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# zsh completions path
fpath=(~/.local/share/zinit/completions $fpath)

# Optimized plugin loading (turbo mode)
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
  zsh-users/zsh-autosuggestions \
  Aloxaf/fzf-tab

# Git plugin from Oh My Zsh (turbo loaded)
zinit ice wait lucid
zinit snippet OMZP::git

# Load Node version manager only when needed
export NVM_COMPLETION=true
export NVM_SYMLINK_CURRENT="true"
zinit wait lucid light-mode for lukechilds/zsh-nvm

zinit cdreplay -q

# History
HISTSIZE=50000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase

# Key bindings
bindkey "^[[1;5C" forward-word          # Ctrl+Right
bindkey "^[[1;5D" backward-word         # Ctrl+Left
bindkey "^[[1;5A" up-line-or-history    # Ctrl+Up
bindkey "^[[1;5B" down-line-or-history  # Ctrl+Down

# macro for tmux-sessionizer
tmux-sessionizer-widget() {
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

clipimg() {
  local file="${1:-clipboard.png}"
  powershell.exe -command "\$img = Get-Clipboard -Format Image; if (\$img) { \$img.Save(\"$(wslpath -w "$(pwd)")\\${file}\") } else { Write-Host 'No image in clipboard' }"
}

# Rust
. "$HOME/.cargo/env"

# Aliases
alias ls="eza"
alias lsa="eza -la"
alias zshconfig="vim ~/.zshrc"
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
