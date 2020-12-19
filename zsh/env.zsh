export UID
export HOST_GID=$(id -g)
export HOST_UID=$(id -u)

# Only connect to a X server in WSL
if [[ $(uname -r) =~ (M|m)icrosoft ]]; then
    export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0
    export LIBGL_ALWAYS_INDIRECT=0
fi

export SAVEHIST=5000
export HISTSIZE=2000
export HISTFILE="$HOME/.zsh_history"
