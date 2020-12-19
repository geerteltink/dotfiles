#alias ls='ls -lh --color=auto --group-directories-first'
alias ls='ls --human-readable --group-directories-first --color=auto -I NTUSER.DAT\* -I ntuser.dat\* -I ntuser.ini -I Cookies -I NetHood -I PrintHood -I Recent -I SendTo -I Templates -I Application\ Data -I Local\ Settings -I Start\ Menu -I My\ Documents'
alias l='ls -CF'
alias l.='ls -d .*'
alias la='ls -A'
alias ll='ls -alF'

alias ..='cd ..'
alias wh='cd /mnt/c/Users/$USER'

alias cp='cp -iv'
alias mv='mv -i'
alias rm='rm -Iv'
alias chmod='chmod --preserve-root'
alias chown='chown --preserve-root'

alias dud='du -ch -d 1 | sort -hr'
alias df='df -Th'

alias update='sudo -- sh -c "apt update && apt -y upgrade && apt -y autoremove && apt -y clean"'
alias reload='source ~/.zshrc'
