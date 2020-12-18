#alias ls='ls -lh --color=auto --group-directories-first'
alias ls='command ls -l --human-readable --group-directories-first --color=auto -I NTUSER.DAT\* -I ntuser.dat\* -I ntuser.ini -I Cookies -I NetHood -I PrintHood -I Recent -I SendTo -I Templates -I Application\ Data -I Local\ Settings -I Start\ Menu -I My\ Documents'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias ..='cd ..'
