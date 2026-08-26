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

# play music
play() {
  mpv --no-video --cookies=yes --ytdl-format=bestaudio "ytdl://ytsearch1:$*"
}

# set kitty terminal padding
lpad() {
  kitten @ set-spacing padding-left=38
}

rpad() {
  kitten @ set-spacing padding-right=38
}

pad() {
  lpad
  rpad
}


padr() { # padding reset
  kitten @ set-spacing padding-left=2
  kitten @ set-spacing padding-right=2
  kitten @ set-spacing padding-top=1
  kitten @ set-spacing padding-bottom=1
}
