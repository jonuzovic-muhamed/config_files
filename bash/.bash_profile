#   ____            _       ____             __ _ _
#  | __ )  __ _ ___| |__   |  _ \ _ __ ___  / _(_) | ___
#  |  _ \ / _` / __| '_ \  | |_) | '__/ _ \| |_| | |/ _ \
#  | |_) | (_| \__ \ | | | |  __/| | | (_) |  _| | |  __/
#  |____/ \__,_|___/_| |_| |_|   |_|  \___/|_| |_|_|\___|

# Needed before the interactive guard: sddm starts sway via a non-interactive login shell
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR:-/run/user/$UID}/openssh_agent"

# Load bashrc for login shells
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
