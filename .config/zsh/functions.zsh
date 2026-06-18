# save clipped img (commenting this out since I created a local script for this)
# clipimg() {
#   local file="${1:-clipboard.png}"
#   powershell.exe -command "\$img = Get-Clipboard -Format Image; if (\$img) { \$img.Save(\"$(wslpath -w "$(pwd)")\\${file}\") } else { Write-Host 'No image in clipboard' }"
# }

# tmux sessionizer
# tmux-sessionizer-widget() { BUFFER="tmux-sessionizer"; zle accept-line; }
# zle -N tmux-sessionizer-widget
# bindkey '^f' tmux-sessionizer-widget

# today note
# _note_today() { notes -t; zle reset-prompt; }
# zle -N _note_today
# bindkey '^n' _note_today

# enable aws completions
enc() {
if command -v aws_completer &> /dev/null; then
  complete -C '/usr/local/bin/aws_completer' aws
fi
}

# tms
tms-widget() {
BUFFER="tms switch";
zle accept-line;
}
zle -N tms-widget
bindkey '^f' tms-widget
