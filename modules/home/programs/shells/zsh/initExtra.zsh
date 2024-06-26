# https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html#Standard-Widgets
tabs -5

bindkey "^[[3;5~" kill-word
bindkey "^H" backward-kill-word
bindkey ";5C" forward-word
bindkey "^[[1;5C" forward-word
bindkey ";5D" backward-word
bindkey "^[[1;5D" backward-word

bindkey "^[[3~" delete-char
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line