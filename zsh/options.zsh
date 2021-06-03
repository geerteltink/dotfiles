# Run cat -v in your favorite terminal emulator to observe key codes.

setopt NO_BEEP
setopt NO_BG_NICE           # don't nice background tasks
setopt NO_CORRECT

setopt AUTO_CD              # If a command is issued that can’t be executed as a normal command, and the command is the name of a directory, perform the cd command to that directory.
setopt C_BASES              # Output hexadecimal numbers in the standard C format
setopt COMPLETE_IN_WORD
setopt EXTENDED_GLOB        # Treat the ‘#’, ‘~’ and ‘^’ characters as part of patterns for filename generation, etc.

setopt APPEND_HISTORY       # adds history
setopt EXTENDED_HISTORY     # add timestamps to history
setopt HIST_IGNORE_ALL_DUPS # don't record dupes in history
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY   # adds history incrementally
setopt SHARE_HISTORY        # share history between sessions ???

SAVEHIST=8192
HISTSIZE=8192

MAILCHECK=0                 # don't check for new mail

bindkey "$terminfo[kcuu1]" history-beginning-search-backward  # arrow-up
bindkey "$terminfo[kcud1]" history-beginning-search-forward   # arrow-down
bindkey "$terminfo[kcub1]" backward-word                      # arrow-left
bindkey "$terminfo[kcuf1]" forward-word                       # arrow-right
