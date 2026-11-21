#  _________  _       ____             __ _ _
# |__  / ___|| |__   |  _ \ _ __ ___  / _(_) | ___
#   / /\___ \| '_ \  | |_) | '__/ _ \| |_| | |/ _ \
#  / /_ ___) | | | | |  __/| | | (_) |  _| | |  __/
# /____|____/|_| |_| |_|   |_|  \___/|_| |_|_|\___|

# Needed before the interactive guard: sddm starts sway via a non-interactive login shell
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR:-/run/user/$UID}/openssh_agent"

# Load zshrc for login shells 