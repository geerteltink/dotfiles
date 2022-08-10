alias ls='ls --human-readable --group-directories-first --color=auto -I NTUSER.DAT\* -I ntuser.dat\* -I ntuser.ini -I Cookies -I NetHood -I PrintHood -I Recent -I SendTo -I Templates -I Application\ Data -I Local\ Settings -I Start\ Menu -I My\ Documents'

# List all files in long format
alias l="ls -lF"

# List all files in long format, excluding . and ..
alias ll="ls -lAF"

# List only directories
alias ld="ls -lF | grep --color=never '^d'"

alias ..='cd ..'
alias wh='cd /mnt/c/Users/$USER'

alias cp='cp -iv'
alias mv='mv -i'
alias rm='rm -Iv'
alias chmod='chmod --preserve-root'
alias chown='chown --preserve-root'

alias dud='du -ch -d 1 | sort -hr'
alias df='df -Th'
alias pw='openssl rand -base64 64'
alias myip="curl http://ipecho.net/plain; echo"

alias update='sudo -- sh -c "apt update && apt -y upgrade && apt -y autoremove && apt -y clean && npm update -g"'

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec ${SHELL} -l"
