export UID
export HOST_GID=$(id -g)
export HOST_UID=$(id -u)

export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0
export LIBGL_ALWAYS_INDIRECT=0
