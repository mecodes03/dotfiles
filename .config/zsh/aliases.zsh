#!/bin/sh

alias brave="brave-browser"
alias vim="nvim"

# Configs
alias nvimrc='vim ~/.config/nvim/'
alias zshrc='vim ~/dotfiles/.zshrc'
alias zshconf='vim ~/dotfiles/.config/zsh/aliases.zsh'
alias tmuxrc='vim ~/dotfiles/.config/tmux/tmux.conf'

alias home="~"
# List Files
alias ls="eza"
alias lsl="eza -l"
alias lsa="eza -la"

# Tmux
alias t="tmux"
alias tls="t ls"
alias tks="t kill-session -t "

alias k="kubectl"
alias python="python3"

alias cdvault="cd ~/vault/work/"

if command -v bat &> /dev/null; then
  alias cat="bat -pp --theme \"Visual Studio Dark+\""
  alias catt="bat --theme \"Visual Studio Dark+\""
fi

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# confirm before overwriting something
# alias cp="cp -i"
# alias mv='mv -i'
# alias rm='rm -i'

# without conforming
alias cpy="cp"
alias mvy='mv'
alias rmy='rm'

alias ytdlp='yt-dlp'

# easier to read disk
alias df='df -h'     # human-readable sizes
alias free='free -m' # show sizes in MB

# get top process eating memory
alias psmem='ps auxf | sort -nr -k 4 | head -5'
# get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3 | head -5'

# systemd
alias mach_list_systemctl="systemctl list-unit-files --state=enabled"

alias mach_java_mode="export SDKMAN_DIR="$HOME/.sdkman" && [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh""
