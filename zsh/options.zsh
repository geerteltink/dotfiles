# Run cat -v in your favorite terminal emulator to observe key codes.

bindkey '^[[A' up-line-or-search   # arrow-up
bindkey '^[[B' down-line-or-search # arrow-down
bindkey '^[[D' backward-word       # arrow-left
bindkey '^[[C' forward-word        # arrow-right

setopt NO_BG_NICE       # don't nice background tasks
setopt NO_HUP
setopt NO_LIST_BEEP
setopt LOCAL_OPTIONS    # allow functions to have local options
setopt LOCAL_TRAPS      # allow functions to have local traps
setopt HIST_VERIFY
setopt SHARE_HISTORY    # share history between sessions ???
setopt EXTENDED_HISTORY # add timestamps to history
setopt PROMPT_SUBST
setopt CORRECT
setopt COMPLETE_IN_WORD
setopt IGNORE_EOF

setopt APPEND_HISTORY                   # adds history
setopt INC_APPEND_HISTORY SHARE_HISTORY # adds history incrementally and share it across sessions
setopt HIST_IGNORE_ALL_DUPS             # don't record dupes in history
setopt HIST_REDUCE_BLANKS
