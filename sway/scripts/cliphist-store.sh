#!/bin/bash

# Store clipboard in cliphist, but skip copies flagged by password managers
# (KeePassXC sets the x-kde-passwordManagerHint=secret mime type).
# Used via: wl-paste --watch ~/.config/sway/scripts/cliphist-store.sh

if wl-paste --list-types 2>/dev/null | grep -qx 'x-kde-passwordManagerHint'; then
  [[ "$(wl-paste --no-newline --type x-kde-passwordManagerHint 2>/dev/null)" == "secret" ]] && exit 0
fi

exec cliphist store -max-items 50
